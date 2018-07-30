function [ UB, time,total_time ] = Main_Function(  )
%MAIN_FUCTION Summary of this function goes here
%   Detailed explanation goes here

%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 1; %
UB_LB = 0; e_now = 1e-5; % Stopping Criterion
kr = 1;

%% Data
%需求点（设施点）数量，设施限制，情景数量，被破坏设施点数量上限，权重1,2
% ni = 25;nj = ni;p = 8;num_k = 5;sum_kj = 4;a1=1;a2=1;
% [c,d,C1,D1,K] = data_city25( num_k,sum_kj);
% 
% % end
% save test;
load test1

%% 
tic
total_time_master = 0;total_time_sub = 0;
while 1>0
    %
    %time_master = tic;
    [y, ~, Obj_Master, Obj_L1,time_master] = Master_model( ni, nj, iteration, kr, K, c, d, C1, D1, p, a1, a2 );
    total_time_master = total_time_master + time_master;
    Obj_Master
    Obj_L1
    %pause 
    %time_master = toc(time_master)
    if LB < Obj_Master
        LB = Obj_Master;
    end
    %
    Obj_sub_all = zeros(1,num_k);
    for nk = 1:num_k
        %time_sub = tic;
        [Obj_sub_all(nk), time_sub] = Sub_model (y, ni, nj, nk, K, C1, D1 );
        total_time_sub = total_time_sub + time_sub;
        %time_sub = toc(time_sub)
    end
    Obj_sub_all 
    [Obj_sub,k_new] = max(Obj_sub_all);k_new
    if UB > (a1*Obj_L1 + a2*Obj_sub)
       UB = a1*Obj_L1 + a2*Obj_sub;
    end
    
    UB_LB = (UB - LB) / LB
    if abs(UB_LB) <= e_now
        UB
        break
    else
        iteration = iteration + 1
        kr = [kr,k_new]; %identified scenario
        
    end
end
time = toc;
total_time = total_time_master + total_time_sub; 
total_time_sub
end

