clear;
% 
% 参数设置
%stage 1
ni = 8;%需求点数量
nj = 6;%可选设施点数量
p = 3;%设施限制
num_k = 3;%情景数量
sum_kj = 3;%被破坏设施点数量上限
%Weights
a1=0.2;a2=0.2;a3=1;
%stage 2  
pk = p;%设施限制
B = 20000;%设施修建成本
R = 1000;%allocation调整成本(|xij - vij|) 
L_max = 800000;
%% 
%L_11 = 0;L_21 = 0;L1_diff = L_11 - L_21;
iteration = 0;
i_end = 1;%循环次数
result = zeros (i_end,6);
%while L1_diff == 0 && iteration <=100
while iteration < i_end
%         ni = 8;%需求点数量
%         nj = 6;%可选设施点数量
%         p = 3;%设施限制
%         num_k = 3;%情景数量
%         sum_kj = 3;%被破坏设施点数量上限
%         %Weights
%         a1=0.2;a2=0.2;a3=1;
%         %stage 2  
%         pk = p;%设施限制
%         B = 20000;%设施修建成本
%         R = 1000;%allocation调整成本(|xij - vij|) 
%         L_max = 800000;
    tic;
    [ L_11,L_12,L_13,y1,x1,u1,v1,c,d,ck,dk,K,C1,C2,D1,D2 ] = location(ni,nj,p,num_k,sum_kj,a1,a2,a3,pk,B,R,L_max);
    %save_data;%
    [ L_21,L_22,L_23,y2,x2,u2,v2 ] = location_compare(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,ck,dk,K,C1,C2,D1,D2);
    %L1_diff = L_11 - L_21;
    iteration = iteration + 1;
    result(iteration,:) = [L_11,L_12,L_13,L_21,L_22,L_23];
    clearvars L_11 L_12 L_13 y1 x1 u1 v1 c d ck dk K C1 C2 D1 D2 L_21 L_22 L_23 y2 x2 u2 v2
    clear global
    clear functions
    time = toc;
    show = ['第',num2str(iteration),'次计算花费时间',num2str(round(time)),'s'];
    disp(show);
    result(iteration,:)
end
a = ['☆☆☆☆☆☆  计 算 ',num2str(i_end),' 次 !  ☆☆☆☆☆☆'];disp(a)
filename = ['\data\result_',num2str(i_end),'_ni=',num2str(ni),'_nj=',num2str(nj),'_p=',num2str(p),'_numk=',num2str(num_k),'_a1a2a3=',num2str(a1),num2str(a2),num2str(a3),num2str(now),'.xls'];
xlswrite(filename,result);

