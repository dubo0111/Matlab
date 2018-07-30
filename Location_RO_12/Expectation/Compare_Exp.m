function [] = Compare_Exp()
clear

%% 2-stage RO
[Obj_L1,Obj_L2 ] = Main_Function;

%% 1-stage SO
%probability of each scenario=0.05, normal situation:0.95^4=0.8=(weight) alpha_2
load test
p_w = zeros(1,num_k);
for i = 1:num_k
    p_w(i) = 0.05;
end
[L1_exp,L2_exp,~] = Expectation (ni,nj,p,c,d,C1,D1,K,num_k,a1,a2,p_w);

%% 
[Obj_L1, Obj_L2;L1_exp,L2_exp;(Obj_L1-L1_exp)/Obj_L1,(Obj_L2-L2_exp)/Obj_L2]


end