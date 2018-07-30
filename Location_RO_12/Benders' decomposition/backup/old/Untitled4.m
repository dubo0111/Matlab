clear
data
t1=tic;
[obj_cc, time_cc] = CC1
t1=toc(t1);

load test1
t2=tic;
[solution_Obj,time] = stage12(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2);
t2=toc(t2);

AAA = [obj_cc,t1;solution_Obj,t2]
time
time_cc 