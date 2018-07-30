clears
[Obj_L1,Obj_L2 ] =Main_Function;
%clear
load test
[L_1,X,Y] = pcenter_L1(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2);
[L_2,W] = pcenter_L2(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2,Y);
A = [Obj_L1,Obj_L2;L_1,L_2]