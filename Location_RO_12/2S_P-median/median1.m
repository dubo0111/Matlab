function [cdx2,cdw2,L1_2,L2_2,value_x,value_y] = median1(  )

%% 2SRO-p-median model
%% initial parameters
%load a1,a2,c,d,C1,D1,K,ni,nj,num_k,p,sum_kj
load test
small_num= 1e-5; % Stopping Criterion
kr = 1:num_k;
iteration = 0;
params.outputflag = 1;
params.TimeLimit = 2000;


%% Master model
% Decision varibles x,y,M;w
%obj          column:x,y,L1(ni*nj+nj+1)
num_col = ni*nj+nj;obj = zeros(1,num_col);
% a1*cdx
cdx=zeros(ni,nj);
for i = 1:ni
    for j =1:ni
        cdx(i,j)=a1*CD(i,j);
    end
end
cdx=reshape(cdx',1,ni*nj);
obj(1:ni*nj)=cdx;
% update vtype
vtype = repmat('B',num_col,1);

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
% %num_row4 = ni;
% A=cat(2,A,zeros(num_row1+num_row2+1,1)); %add column
% A4 = zeros(ni,num_col);A4(:,num_col)=-1;
% n_col = 1;
% for i = 1:ni
%     for j =1:nj
%         A4(i,n_col) = CD(i,j);
%         n_col = n_col+1; %column by column
%     end
% end
% A=cat(1,A,A4);A=sparse(A);
% sense = cat(1,sense,repmat('<',ni,1));
% rhs = cat(1,rhs,zeros(ni,1));

%% Master model: Preparation for further update
% add M
row_now = num_row1+num_row2+1;
obj=[obj';a2];A = [A,zeros(row_now,1)];vtype = [vtype;'C'];
num_col = num_col+1;col_M=num_col;

% Update constraints (using blkdiag)
num_new_col=(ni*nj);
%A = [A,zeros(row_now,num_new_col)];  % add column
%              (5)       cd1w-M<0     update M in the loop
row5=1;
A5 = ones(1,num_new_col);
%
% na=1;
% for i = 1:ni
%     for j = 1:nj
%         A5(na)=CD1(i,j);
%         na=na+1;
%     end
% end

%              (6)       w_ij-y_j<0     update yj in the loop
% only constraints involved with first stage variable 分块对角阵+更新yj,cd1(k)w
row6=ni*nj;
A6 = [eye(row6)];
col_y = ni*nj+1;
%              (7)       w_ij<1-k_j       rhs update needed
row7=ni*nj;
A7 = [eye(row7)];
%              (8)       sum w_ij = 1 forall i
row8=ni;
A81 = ones(1,nj);A8=[];
for i = 1:ni
    A8 = blkdiag(A8,A81);
end
%A8 = [A8,zeros(row8,1)];
%   delete!       (9)       sum cd1w-L2<0  forall i  update in loop 放在头尾便于更新cd1(k)w
%row9 = ni;
% updating base
A_new = [A6;A7;A8];
sense_new = [repmat('<',row5+row6+row7,1);repmat('=',row8,1)];
rhs_new1 = zeros(row5+row6,1);rhs_new2=ones(row8,1);

sum_row_new = 1+ni+ni*nj+ni*nj;
%row_now = row_now + sum_row_2 ;  %update row number

for nk = 1:num_k
    %%  update master problem model
    % Decision varibles x,y,L1; M; for each scenario k: w,L2
    % obj    column:(ni*nj+nj+1)+1+(ni*nj+1)*iteration
    obj=[obj;zeros(num_new_col,1)];obj(col_M)=a2;
    %vtype=[vtype;repmat('C',num_new_col,1)]; %
    vtype=[vtype;repmat('B',num_new_col,1)];%vtype(num_new_col)='C';
    % Update constraints
    %              (5)       cd1w-M<0     update M in the loop
    %              (6)       w_ij-y_j<0     update yj in the loop
    %              ****delete (9)       sum cd1w-L2<0  forall i  update in loop 放在头尾便于更新cd1(k)w
%     A91=zeros(1,nj);A9=[];
%     for i = 1:ni
%         for j = 1:nj
%         A91(j)=CD1{kr(nk)}(i,j);
%         end
%         A9=blkdiag(A9,A91);
%     end
%     A9 = [A9,-ones(row9,1)];
%     A_new1 = [A_new;A9];A_new1=sparse(A_new1);
    
    %(5)
   % A(row_now+1,col_M)=-1; %M
    na=1;A51=A5;
    for i=1:ni
        for j=1:nj
            A51(na)=CD1{nk}(i,j);
            na=na+1;
        end
    end
    A_new1=[A51;A_new];
   
    A_new1=sparse(A_new1);
    A = blkdiag(A,A_new1);%
     A(row_now+1,col_M)=-1; %M
    %(6)
    A(row_now+1+1:row_now+1+ni*nj,col_y:col_y-1+nj)=repmat(-eye(nj),ni,1); 
    %update rhs(1-kj) ,sense 
    sense = [sense;sense_new];
    rhs_new=zeros(nj,1);
    for j = 1:nj
        rhs_new(j) = 1-K{kr(nk)}(j);
    end
    rhs_new = repmat(rhs_new,ni,1);
    rhs_new=[rhs_new1;rhs_new;rhs_new2];
    rhs=[rhs;rhs_new];
    row_now = row_now + sum_row_new ;  %update row number
end
clear model
model.A = A; model.obj=obj'; model.sense=sense; model.rhs=rhs; model.vtype=vtype;
result = gurobi(model,params);
if strcmp(result.status,'OPTIMAL')==0
    iteration = -inf;
end
%cdx2,cdw2,L1_2,L2_2,value_x,value_y
X=result.x;
value_x=X(1:ni*nj);
value_x=reshape(value_x',ni,nj)';
value_y = X(ni*nj+1:ni*nj+nj);
%
cdw2=X(col_M);
%
cdx2=0;
for i = 1:ni
    for j =1:nj
        cdx2=cdx2+CD(i,j)*value_x(i,j);
    end
end
%L1_2
cdx=zeros(ni,nj);
for i =1:ni
    for j = 1:nj
        cdx(i,j)=CD(i,j)*value_x(i,j);
    end
end
L1_2=max(max(cdx));
%biggest L2_2 under all scenario 
cdw_all=X;
cdw_all(1:ni*nj+nj+1)=[];
CDW=cell(1,num_k);
M_cdw=zeros(1,num_k);
for nk=1:num_k
    cdw=zeros(ni,nj);
    value_w=cdw_all(1:ni*nj);cdw_all(1:ni*nj)=[];
    value_w=reshape(value_w',ni,nj)';
    for i = 1:ni
        for j =1:nj
            cdw(i,j)=CD1{nk}(i,j)*value_w(i,j);
        end
    end
%     M_cdw(nk)=sum(sum(cdw));
CDW{nk}=cdw;
end
L2=zeros(1,num_k);
for nk=1:num_k
    L2(nk)=max(max(CDW{nk}));
end
L2_2=max(L2);



end
