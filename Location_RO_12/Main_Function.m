function [  ] = Main_Function(  )
%MAIN_FUCTION Summary of this function goes here
%   Detailed explanation goes here
clear
%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 1; %
UB_LB = 0; e_now = 1e-5; % Stopping Criterion
kr = 1;

%% Data
%����㣨��ʩ�㣩��������ʩ���ƣ��龰���������ƻ���ʩ���������ޣ�Ȩ��1,2
ni = 5;nj = ni;p = 3;num_k = 5;sum_kj =2;a1=1;a2=1;
[c,d,C1,D1,K] = data_generation(ni,num_k,sum_kj);

%load test
save test;


%% 
tic
while 1>0
    %
    time_master = tic;
    [y, ~, Obj_Master, Obj_L1] = Master_model( ni, nj, iteration, kr, K, c, d, C1, D1, p, a1, a2 );
    time_master = toc(time_master)
    if LB < Obj_Master
        LB = Obj_Master;
    end
    %
    Obj_sub_all = zeros(1,num_k);
    for nk = 1:num_k
        time_sub = tic;
        Obj_sub_all(nk) = Sub_model (y, ni, nj, nk, K, C1, D1 );
        time_sub = toc(time_sub)
    end
    [Obj_sub,k_new] = max(Obj_sub_all);
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
toc




end

