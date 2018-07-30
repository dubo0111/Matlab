clear
load('C:\Users\Du Bo\Google ‘∆∂À”≤≈Ã\Matlab\Location_RO_12\COMPARE\local\50_3_100_10_0.5.mat')
t1=tic;
[iter1, obj1, gap1] = CCG_gurobi_1( a1,p,ni,nj,CD,CD1,K,num_k );
t1=toc(t1);
t2=tic;
[iter2, obj2, gap2] = BDD_gurobi( a1,p,ni,nj,CD,CD1,K,num_k );
t2=toc(t2);
t3=tic;
[iter3, obj3, gap3] = LIP_gurobi1( a1,p,ni,nj,CD,CD1,K,num_k);
t3=toc(t3);
save