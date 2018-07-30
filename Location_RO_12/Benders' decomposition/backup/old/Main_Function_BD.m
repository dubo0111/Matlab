function [UB,time1, total_time] = Main_Function_BD( ni,nj,p,num_k,a1,a2,c,d,C1,D1,K )
%MAIN_FUCTION Summary of this function goes here
%   Detailed explanation goes here

%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 0; %
UB_LB = 0; e_now = 1e-5; % Stopping Criterion
kr = [];
F={};G={};H={};

%% Data
%需求点（设施点）数量，设施限制，情景数量，被破坏设施点数量上限，权重1,2
% ni = 6;nj = ni;p = 3;num_k = 3;sum_kj = 2;a1=1;a2=1;
% [c,d,C1,D1,K] = data_generation(ni,num_k,sum_kj);
% 
% save test;

%% 
total_time_master = 0;total_time_sub = 0;
tic
while 1>0
    %
    %t1=tic;
    [y, x, Obj_Master, Obj_L1,Obj_L2, time_master] = Master_model_BD( ni, nj, iteration, kr, K, c, d, C1, D1, p, a1, a2 , F, G, H);
    %time_master=toc(t1)
    total_time_master = total_time_master + time_master;
    if LB < Obj_Master
        LB = Obj_Master;
    end
    %
    Obj_sub_all = zeros(1,num_k);f = cell(1,num_k);g = cell(1,num_k);h = cell(1,num_k);
    for nk = 1:num_k
        %t2=tic;
        [f{nk}, g{nk}, h{nk}, Obj_sub_all(nk), time_sub] = Sub_model_BD (y, ni, nj, nk, K, C1, D1 );
        total_time_sub = total_time_sub + time_sub;
        %time_sub=toc(t2)
    end
    [Obj_sub,k_new] = max(Obj_sub_all);
    if UB > (a1*Obj_L1 + a2*Obj_sub)
       UB = a1*Obj_L1 + a2*Obj_sub;
    end
    
    UB_LB = (UB - LB) / LB
    if abs(UB_LB) <= e_now
        
        break
    else
        iteration = iteration + 1
        kr = [kr,k_new] %identified scenario
        F{iteration} = f{k_new};G{iteration} = g{k_new};H{iteration} = h{k_new};
    end
end
time1 = toc;
total_time = total_time_master + total_time_sub;



end

