function [Obj_value_LIP ] = p_center(  )

%% initial parameters
%load a1,a2,c,d,C1,D1,K,ni,nj,num_k,p,sum_kj
load test1
small_num= 1e-5; % Stopping Criterion
kr = 1:num_k;
iteration = 0;
params.outputflag = 1;
params.TimeLimit = 1000;


%% Master model
% Decision varibles x,y,L1; M; w,L2
%obj          column:x,y,L1(ni*nj+nj+1)
num_col = ni*nj+nj+1;obj = zeros(1,num_col);
% a1*L1
obj(num_col)=1;
% update vtype
vtype = repmat('B',ni*nj,1);
vtype = [vtype; repmat('C',nj+1,1)];
vtype(num_col)='C';

% constraints
%               (1)   x_ij-y_j<=0
num_row1 = ni*nj;
A1=speye(ni*nj);
B1=repmat(-speye(nj),ni,1);
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
if strcmp(result.status,'OPTIMAL')==0
    iteration = -inf;
end
Obj_value_LIP = result.objval;
result.x;
runtime=result.runtime;
end
