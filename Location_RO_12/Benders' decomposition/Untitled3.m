clear

a1 = 0.5; a2 = 1-a1; p = 8; sum_kj = 6; city = 49;

num_k=5;
data(a1,a2, num_k ,p, sum_kj, city)

t0=tic;
[iter0, obj0]=BDD_gurobi;%
t0=toc(t0);
% t01=tic;
% [iter01, obj01]=BDD_gurobi_1;%
% t01=toc(t01);
% t0
% t01
% t1=tic;
% [iter1, obj1]=BDD_gurobi;%
% t1=toc(t1);
% t2 = tic;
% [iter2, obj2] = LIP_gurobi1;%
% t2 = toc(t2);

%A=[A;city,p,a1,a2,num_k,t0,t1,t2,iter0,iter1,iter2]