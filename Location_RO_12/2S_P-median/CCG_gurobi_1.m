function [iteration, UB, Gap] = CCG_gurobi_1(  )
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
load test

%% Master model
% Decision varibles x,y,L1; w,L2,eta
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

[Obj_sub, kr_new] = CCG_sub( y,K,CD1,num_k,nj );

%% Master model: Preparation for further update
% add eta
row_now = num_row1+num_row2+1+ni;
obj=[obj';0];A = [A,zeros(row_now,1)];vtype = [vtype;'C'];
num_col = num_col+1;col_eta=num_col;
% Update constraints (using blkdiag)
num_new_col=(ni*nj+1);
%A = [A,zeros(row_now,num_new_col)];  % add column
%              (5)       L2(k)-eta<0     update eta in the loop
row5=1;
A5 = zeros(1,num_new_col);A5(num_new_col)=1;
%              (6)       w_ij-y_j<0     update yj in the loop
% only constraints involved with first stage variable 分块对角阵+更新yj,cd1(k)w
row6=ni*nj;
A6 = [eye(row6),zeros(row6,1)];
col_y = ni*nj+1;
%              (7)       w_ij<1-k_j       rhs update needed
row7=ni*nj;
A7 = [eye(row7),zeros(row7,1)];
%              (8)       sum w_ij = 1 forall i
row8=ni;
A81 = ones(1,nj);A8=[];
for i = 1:ni
    A8 = blkdiag(A8,A81);
end
A8 = [A8,zeros(row8,1)];
%              (9)       sum cd1w-L2<0  forall i  update in loop 放在头尾便于更新cd1(k)w
row9 = ni;
% update
A_new = [A5;A6;A7;A8];
sense_new = [repmat('<',row5+row6+row7,1);repmat('=',row8,1);repmat('<',row9,1)];
rhs_new1 = zeros(row5+row6,1);rhs_new2=[ones(row8,1);zeros(row9,1)];

sum_row_new = 1+ni+ni*nj+ni*nj+ni;

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
    Gap = (UB - LB) / UB
 
    if abs(Gap) <= e_now
        obj_value_CCG = UB
        break
    else
        iteration = iteration + 1;
        dispcontent = ['*****************iteration',num2str(iteration),'*****************'];
        disp(dispcontent);   
        kr = [kr,kr_new] %identified scenario
        %kr=1:1:iteration
    end
    %%  update master problem model
    % Decision varibles x,y,L1; eta; for each scenario k: w,L2
    % obj    column:(ni*nj+nj+1)+1+(ni*nj+1)*iteration
    obj=[obj;zeros(num_new_col,1)];obj(col_eta)=a2;
    %vtype=[vtype;repmat('C',num_new_col,1)]; %
    vtype=[vtype;repmat('B',num_new_col-1,1);'C'];%vtype(num_new_col)='C';
    % Update constraints
    %              (5)       L2-eta<0     update eta in the loop
    %              (6)       w_ij-y_j<0     update yj in the loop
    %              (9)       sum cd1w-L2<0  forall i  update in loop 放在头尾便于更新cd1(k)w
    A91=zeros(1,nj);A9=[];
    for i = 1:ni
        for j = 1:nj
        A91(j)=CD1{kr(iteration)}(i,j);
        end
        A9=blkdiag(A9,A91);
    end
    A9 = [A9,-ones(row9,1)];
    A_new1 = [A_new;A9];A_new1=sparse(A_new1);
    A = blkdiag(A,A_new1);
    A(row_now+1,col_eta)=-1; %(5)
    A(row_now+1+1:row_now+1+ni*nj,col_y:col_y-1+nj)=repmat(-eye(nj),ni,1); %6
    %update rhs(1-kj) ,sense 
    sense = [sense;sense_new];
    rhs_new=zeros(nj,1);
    for j = 1:nj
        rhs_new(j) = 1-K{kr(iteration)}(j);
    end
    rhs_new = repmat(rhs_new,ni,1);
    rhs_new=[rhs_new1;rhs_new;rhs_new2];
    rhs=[rhs;rhs_new];
    row_now = row_now + sum_row_new ;  %update row number
    clear model
    model.A = A; model.obj=obj'; model.sense=sense; model.rhs=rhs; model.vtype=vtype;
    result = gurobi(model,params);
    %extract y, objective value
    y=result.x(y_index+1:y_index+nj);
    Obj_L1=result.x(num_col-1);
    Obj_Master = result.objval;
    
   [Obj_sub, kr_new] = CCG_sub( y,K,CD1,num_k,nj )

    if iteration > num_k
        disp('!!!!!!!!!!!!fail!!!!!!!!!!!!!!!');
        %iteration=-inf;
        break
    end
end


X=result.x;
X(col_eta)








end