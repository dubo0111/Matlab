function [ L_21,L_22,L_23,y2,x2,u2,v2 ] = location_compare(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,ck,dk,K,C1,C2,D1,D2)

%% 
num_obj = 2;%目标=1:robust目标;目标=2：普通p-center
[L_21,y,x] = model_1(ni,nj,p,c,d,C1,C2,D1,D2,K,num_k,a1,a2,a3,num_obj);

%% 
[ck, dk] = real_cd(c,d);
n=1;% 发生的情景
yy=value(y);xx=value(x);
[L_23,u,v] = model_2(K ,n, yy , xx , ck ,dk ,pk, B, R, L_max);
%%
[ L_22,~ ] = model_L2( yy,K,n,ck,dk,ni,nj );
%%
y2=yy;
x2=xx;
u2=value(u);
v2=value(v);




end