function [ cost,cost_t,cost_b,cost_r,L_11,L_12,L_13,y1,x1,u1,v1,w1 ] = location_draw(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,C1,D1,C2,D2,K,ck,dk,n)
%LOCATION_DRAW Two-stage Location Problem Combination with Figures

%% 1灾前规划
num_obj = 1;
[L_11,y, x] = model_1(ni,nj,p,c,d,C1,C2,D1,D2,K,num_k,a1,a2,a3,num_obj);
yy=value(y);xx=value(x);

%% 2灾后反应
[ L_12,w1 ] = model_L2( yy,K,n,ck,dk,ni,nj );

%% 3设施重建

[cost,cost_t,cost_b,cost_r,L_13,u, v] = model_2(K ,n, yy , xx , ck ,dk ,pk, B, R, L_max);


%%
y1=yy;
x1=xx;
u1=value(u);
v1=value(v);




end
