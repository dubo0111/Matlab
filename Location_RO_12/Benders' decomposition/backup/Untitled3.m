clear

a1 = 0.5; a2 = 1-a1; p = 3; sum_kj = 2; city = 49;

num_k=30;
data(a1,a2, num_k ,p, sum_kj, city)

t0=tic;
[iter0, obj0]=CCG_gurobi;%
t0=toc(t0);
t1=tic;
[iter1, obj1]=BDD_gurobi;%
t1=toc(t1);
t2 = tic;
[iter2, obj2] = LIP_gurobi1;%
t2 = toc(t2);

A=[A;city,p,a1,a2,num_k,t0,t1,t2,iter0,iter1,iter2]