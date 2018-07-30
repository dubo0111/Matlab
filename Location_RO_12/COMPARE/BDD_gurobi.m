function [ iteration, UB, Gap ] = BDD_gurobi( a1,p,ni,nj,CD,CD1,K,num_k )
%C&CG_GUROBI Column-and-caints generation algorithm using solver gurobi
%Gurobi model: A,obj,sense,rhs,vtype

%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 0; %
Gap = 0; e_now = 1e-5; % Stopping Criterion
kr = []; % identified scenario in each iteration
t0=tic;
params.outputflag = 0;
%load a1,a2,c,d,C1,D1,K,ni,nj,num_k,p,sum_kj
a2=1-a1;
yy={};
%% Master model
% Decision varibles x,y,L1,eta
%obj          column:x,y,L1(ni*nj+nj+1)
num_col = ni*nj+nj+1;obj = zeros(1,num_col);
% a1*L1
obj(num_col)=a1;
% update vtype
vtype = repmat('B',num_col,1);vtype(num_col)='C';

% constraints
%               (1)   x_ij-y_j<=0
num_row1 = ni*nj;
A1=eye(ni*nj);
B1=repmat(-eye(nj),ni,1);
%update A
A=[A1,B1];
%update sense
sense = repmat('<',num_row1,1);
%update rhs
rhs = zeros(num_row1,1);
%              (2)   sum x_ij = 1  forall i
num_row2 = ni;
A2 = zeros(ni,ni*nj);n_col=1;
for i = 1:ni
    for j = 1:nj
        A2(i,n_col)=1;
        n_col = n_col+1;
    end
end
A2 = [A2,zeros(num_row2,nj)];
A = cat(1,A,A2);
sense =cat(1,sense, repmat('=',num_row2,1));
rhs = cat(1,rhs,ones(num_row2,1));
%              (3)   sum y_j <= p
%num_row3=1
A3 = [zeros(1,num_row1),ones(1,nj)];
A = cat(1,A,A3);
sense = cat(1,sense, repmat('<',1,1));
rhs = cat(1,rhs,p);
%              (4)    cd*x-L1<0
%num_row4 = ni;
A=cat(2,A,zeros(num_row1+num_row2+1,1)); %add column
A4 = zeros(ni,num_col);A4(:,num_col)=-1;
n_col = 1;
for i = 1:ni
    for j =1:nj
        A4(i,n_col) = CD(i,j);
        n_col = n_col+1; %column by column
    end
end
A=cat(1,A,A4);A=sparse(A);
sense = cat(1,sense,repmat('<',ni,1));
rhs = cat(1,rhs,zeros(ni,1));
clear model
model.A = A; model.obj=obj'; model.sense=sense; model.rhs=rhs; model.vtype=vtype;
result = gurobi(model,params);
% extract y, objective value
y_index=ni*nj;y=result.x(y_index+1:y_index+nj);
Obj_L1=result.x(num_col);
Obj_Master = result.objval;

%% Master model: Preparation for further update
% add eta
row_now = num_row1+num_row2+1+ni;
obj=[obj';a2];A = [A,zeros(row_now,1)];vtype = [vtype;'C'];
num_col = num_col+1;col_eta=num_col;
% Update constraints (using blkdiag)

%% Sub model
% Decision variables e_i h_i f_ij g_ij Q_k (for each scenario)
% obj column: £¨ni +ni+ni*nj+ni*nj)
num_col_subk = (ni+ni+ni*nj+ni*nj);
num_col_sub=num_col_subk* num_k+num_k;
% Sub problem Objective
% sum Q_k
obj_sub = zeros(num_col_sub,1);obj_sub(num_col_sub-num_k+1:num_col_sub)=1;

vtype_sub=repmat('C',num_col_sub,1);

% constraints
%            (10) for each scenario k     cd1*e_i + h_i + f_ij +g _ij <= 0
n_row10=ni*nj;
AA1=zeros(n_row10,ni);AA2=AA1;A_sub0=[];
add_row=1;
for i = 1:ni
    for j = 1:nj;
        AA2(add_row,i)=1;
        add_row = add_row+1;
    end
end
AA2 = [AA2,eye(n_row10),eye(n_row10)];
for k = 1:num_k
    add_row=1;
    for i = 1:ni
        for j = 1:nj
            AA1(add_row,i)=CD1{k}(i,j);
            add_row = add_row+1;
        end
    end
    AA = [AA1,AA2];
    %            (11) for each scenario k     sum(e_i))=-1
    %n_row11= 1
    AA3=zeros(1,num_col_subk);AA3(1:ni)=1;
    AA=[AA;AA3];AA=sparse(AA);
    A_sub0 = blkdiag(A_sub0,AA);
end    
%                (12)0*ei+sum h_i+sum(sum(y_j*f_ij))+sum(sum((1-k_j)*g_ij)) - Q(k) =0     for each scenario k
n_row12 = num_k;
%add column for Q
A_sub0 = [A_sub0,sparse(zeros((n_row10+1)*num_k,num_k))];

c12_sub=[];%Q=zeros(num_k,1);
c12_e = zeros(ni,1);c12_h = ones(ni,1);
c12_f = zeros(ni,nj);
for i = 1:ni
    for j = 1:nj
        c12_f(i,j) = y(j);
    end
end
c12_f = reshape(c12_f',ni*nj,1);
c12_G=cell(1,4);
for k = 1:num_k
    c12_g = zeros(i,j);
    for i = 1:ni
        for j = 1:nj
            c12_g(i,j)=1-K{k}(j);
        end
    end
    c12_g = reshape(c12_g',ni*nj,1); c12_G{k}=c12_g;
    c12_sub0 = [c12_e;c12_h;c12_f;c12_g];c12_sub0 = sparse(c12_sub0);
    c12_sub=blkdiag(c12_sub,c12_sub0');
end
c12_sub=[c12_sub,-eye(num_k)];c12_sub = sparse(c12_sub);
A_sub=[A_sub0;c12_sub];
%
sense_sub = repmat('<',n_row10,1);sense_sub=[sense_sub;'='];
sense_sub=repmat(sense_sub,num_k,1);sense_sub=[sense_sub;repmat('=',num_k,1)];
rhs_sub = zeros(n_row10,1);rhs_sub=[rhs_sub;-1];
rhs_sub=repmat(rhs_sub,num_k,1);rhs_sub=[rhs_sub;zeros(num_k,1)];
%                   for each scenario k     e f g<0 g Q(k) free: set lb ub.
lb = repmat(-inf,num_col_sub,1);
ub = [zeros(ni,1);inf(ni,1);zeros(ni*nj+ni*nj,1)];ub=repmat(ub,num_k,1);ub=[ub;inf(num_k,1)];

model_sub.A = A_sub; model_sub.sense=sense_sub; model_sub.rhs=rhs_sub; 
model_sub.vtype=vtype_sub;model_sub.obj=obj_sub;model_sub.modelsense='max';model_sub.lb=lb;model_sub.ub=ub;
result_sub = gurobi(model_sub,params) ;
% extract k,objective value, 
x_sub = result_sub.x;
value_Q = x_sub(num_col_sub-num_k+1:num_col_sub);
[Obj_sub,kr_new] = max(value_Q);
num_opt = (kr_new-1)*num_col_subk;
x_sub = x_sub(num_opt+1:num_opt+num_col_subk);x_sub(1:ni)=[];
h_sub = x_sub(1:ni);x_sub(1:ni)=[];
f_sub = x_sub(1:ni*nj);x_sub(1:ni*nj)=[];
g_sub = x_sub(1:ni*nj);
f_sub=reshape(f_sub,ni,nj);f_sub=f_sub';
g_sub=reshape(g_sub,ni,nj);g_sub=g_sub';
while 1
    t1=toc(t0);
    if t1 > 1000
        %iteration = -inf;
        break
    end
    if LB < Obj_Master
        LB = Obj_Master;
    end
    if UB > (a1*Obj_L1 + a2*Obj_sub)
       UB = a1*Obj_L1 + a2*Obj_sub;
    end
    Gap = (UB - LB) / UB;
 
    if abs(Gap) <= e_now
        obj_value_BDD = UB;
        break
    else
        iteration = iteration + 1;
%         dispcontent = ['*****************iteration',num2str(iteration),'*****************'];
%         disp(dispcontent);   
        kr = [kr,kr_new]; %identified scenario
        %kr=1:1:iteration
    end
    %%  update cutting plane
    % Decision varibles x,y,L1; eta; 
    % obj    column:(ni*nj+nj+1)+1iteration
    % sum(sum(y_j f_ij*)) - eta <= -(sum h_i*+sum(sum((1-k_j)*g_ij)))
    cp_y=zeros(1,nj);cp_g=0;
    for j =1:nj
        for i = 1:ni
            cp_y(j)=cp_y(j)+f_sub(i,j);
            cp_g=cp_g+(1-K{kr(iteration)}(j))*g_sub(i,j);
        end
    end
    cp=[zeros(1,ni*nj),cp_y,0,-1];cp=sparse(cp);
    A=[A;cp];
    sense=[sense;'<'];
    rhs=[rhs;-(cp_g+sum(h_sub))];
        
    clear model;
    model.A = sparse(A); model.obj=obj'; model.sense=sense; model.rhs=rhs; model.vtype=vtype;
    result = gurobi(model,params);
    %extract y, objective value
    y=result.x(y_index+1:y_index+nj);
    yy{iteration}=y;
    Obj_L1=result.x(num_col-1);
    Obj_Master = result.objval;
    %% update sub problem 
    %(12)0*ei+sum h_i+sum(sum(y_j*f_ij))+sum(sum((1-k_j)*g_ij)) - Q(k) =0     for each scenario k
    c12_f = zeros(ni,nj);c12_sub=[];
    for i = 1:ni
        for j = 1:nj
            c12_f(i,j) = y(j);
        end
    end
    c12_f = reshape(c12_f',ni*nj,1);
    for k = 1:num_k
        c12_sub0 = [c12_e;c12_h;c12_f;c12_G{k}];c12_sub0 = sparse(c12_sub0);
        c12_sub=blkdiag(c12_sub,c12_sub0');
    end
    c12_sub=[c12_sub,-eye(num_k)];
    A_sub=[A_sub0;c12_sub];
    model_sub.A = sparse(A_sub);
    result_sub = gurobi(model_sub,params) ;
    % extract k,objective value, 
    if strcmp(result_sub.status,'OPTIMAL')==0
        pause
    end
    x_sub = result_sub.x;
    value_Q = x_sub(num_col_sub-num_k+1:num_col_sub);
    [Obj_sub,kr_new] = max(value_Q);
    num_opt = (kr_new-1)*num_col_subk;
    x_sub = x_sub(num_opt+1:num_opt+num_col_subk);x_sub(1:ni)=[];
    h_sub = x_sub(1:ni);x_sub(1:ni)=[];
    f_sub = x_sub(1:ni*nj);x_sub(1:ni*nj)=[];
    g_sub = x_sub(1:ni*nj);
    f_sub=reshape(f_sub,ni,nj);f_sub=f_sub';
    g_sub=reshape(g_sub,ni,nj);g_sub=g_sub';
%      if iteration > num_k*5
%          disp('!!!!!!!!!!!!fail!!!!!!!!!!!!!!!');
%          break
%      end
end











end