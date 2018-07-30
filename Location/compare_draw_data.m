%clear all;

%% 参数设置
% %stage 
% ni = 10;%需求点数量
% nj = 6;%可选设施点数量
% p = 3;%设施限制
% num_k = 3;%情景数量
% sum_kj = 3;%被破坏设施点数量上限
% %Weights
% a1=0.2;a2=0;a3=1;
% %stage 2  
% pk = p;%设施限制
 B = 1;%设施修建成本
% R = 1000;%allocation调整成本(|xij - vij|) 
% L_max = 800000;
% n = 1;%实际发生的情景


%% 
iteration = 0;
i_end = 1;%循环次数
result = zeros (i_end,8);
while iteration < i_end
% %% 随机生成数据
% xy_demand = randi(100,2,ni);xy_facility = randi(100,2,nj);% 随机生成需求点和可选设施位置
% c = distance(xy_demand,xy_facility);%计算距离(成本)矩阵
% d = randi(100,ni,1);% 随机生成需求
% [ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d );
% [ K ] = scenario_k( sum_kj,num_k,nj );% 随机生成情景集
% [ck, dk] = real_cd(c,d);% 随机生成stage_2实际成本和需求

%% 计算

   tic;
    [ cost1,L_11,L_12,L_13,y1,x1,u1,v1,w1] = location_draw(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,C1,D1,C2,D2,K,ck,dk,n);
    [ cost2,L_21,L_22,L_23,y2,x2,u2,v2,w2] = location_draw_compare(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,ck,dk,K,C1,C2,D1,D2,n);
    iteration = iteration + 1;
    result(iteration,:) = [L_11,L_12,L_13,cost1,L_21,L_22,L_23,cost2];
    %clearvars L_11 L_12 L_13 y1 x1 u1 v1 c d ck dk K C1 C2 D1 D2 L_21 L_22 L_23 y2 x2 u2 v2
    clear global
    clear functions %清空函数加快运行速度（可能cplex或yalmip累积的一个全局变量LUbounds的内存占用越来越大)
    time = toc;
    show = ['第',num2str(iteration),'次计算花费时间',num2str(round(time)),'s'];
    disp(show);
    result(iteration,:)
    draw
    
end
a = ['☆☆☆☆☆☆  计 算 ',num2str(i_end),' 次 !  ☆☆☆☆☆☆'];disp(a)
%  filename = ['result_',num2str(i_end),'_ni=',num2str(ni),'_nj=',num2str(nj),'_p=',num2str(p),'_numk=',num2str(num_k),'_a1a2a3=',num2str(a1),num2str(a2),num2str(a3),num2str(now),'.xls'];
%  %xlswrite(filename,result);
%  %run

