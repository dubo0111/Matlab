clear

a1 = 0.5; a2 = 1-a1; p = 2; sum_kj = 1; city = 6;

num_k=10;
data(a1,a2, num_k ,p, sum_kj, city)

t0=tic;
[iter0, obj0]=CCG_gurobi;%
t0=toc(t0);


%A=[A;city,p,a1,a2,num_k,t0,t1,t2,iter0,iter1,iter2]