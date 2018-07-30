function [ L_11,L_12,L_13,y1,x1,u1,v1,c,d,ck,dk,K,C1,C2,D1,D2 ] = location(ni,nj,p,num_k,sum_kj,a1,a2,a3,pk,B,R,L_max)
%LOCATION Two-stage Location Problem Combination
% 第一阶段
% 输入：ni;%需求点数量;nj;%可选设施点数量 p;
%     权重：a1,a2,a3;设施限制;成本及需求矩阵:c,d,C1(k),D1(k),C2(k),D2(k),情景数量num_k,破坏设施上限sum_kj
% 输出：y;x
% 第二阶段
% 输入：实际情景K{n}；实际成本及需求，c'(ck),d'(dk);y,x;
% 输出：u;v
% %% Parameters Settings
% ni = 5;%需求点数量
% nj = 4;%可选设施点数量
% p = 2;%设施限制
% %q = 1;%破坏设施限制（这个约束可能没有必要）
c = randi(100,ni,nj);%成本矩阵
d = randi(100,ni,1);%需求矩阵
% 随机生成情景集
% num_k = 4;%情景的数量
% sum_kj = 2;%被破坏设施点数量上限
[ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d );
[ K ] = scenario_k( sum_kj,num_k,nj );
% %Weights
% a1=0.05;a2=0.25;a3=0.25;
% 
% pk = 2;%设施限制
% B = 50;%设施修建成本
% R = 200;%allocation调整成本(|xij - vij|)
% L_max = 80000;
%% 
num_obj = 1;
[L_11,y, x] = model_1(ni,nj,p,c,d,C1,C2,D1,D2,K,num_k,a1,a2,a3,num_obj);

%% 
[ck, dk] = real_cd(c,d);
n=1;% 发生的情景
yy=value(y);xx=value(x);
[L_13,u, v] = model_2(K ,n, yy , xx , ck ,dk ,pk, B, R, L_max);

%%
[ L_12,~ ] = model_L2( yy,K,n,ck,dk,ni,nj );

%%
y1=yy;
x1=xx;
u1=value(u);
v1=value(v);




end
