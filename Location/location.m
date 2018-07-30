function [ L_11,L_12,L_13,y1,x1,u1,v1,c,d,ck,dk,K,C1,C2,D1,D2 ] = location(ni,nj,p,num_k,sum_kj,a1,a2,a3,pk,B,R,L_max)
%LOCATION Two-stage Location Problem Combination
% ��һ�׶�
% ���룺ni;%���������;nj;%��ѡ��ʩ������ p;
%     Ȩ�أ�a1,a2,a3;��ʩ����;�ɱ����������:c,d,C1(k),D1(k),C2(k),D2(k),�龰����num_k,�ƻ���ʩ����sum_kj
% �����y;x
% �ڶ��׶�
% ���룺ʵ���龰K{n}��ʵ�ʳɱ�������c'(ck),d'(dk);y,x;
% �����u;v
% %% Parameters Settings
% ni = 5;%���������
% nj = 4;%��ѡ��ʩ������
% p = 2;%��ʩ����
% %q = 1;%�ƻ���ʩ���ƣ����Լ������û�б�Ҫ��
c = randi(100,ni,nj);%�ɱ�����
d = randi(100,ni,1);%�������
% ��������龰��
% num_k = 4;%�龰������
% sum_kj = 2;%���ƻ���ʩ����������
[ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d );
[ K ] = scenario_k( sum_kj,num_k,nj );
% %Weights
% a1=0.05;a2=0.25;a3=0.25;
% 
% pk = 2;%��ʩ����
% B = 50;%��ʩ�޽��ɱ�
% R = 200;%allocation�����ɱ�(|xij - vij|)
% L_max = 80000;
%% 
num_obj = 1;
[L_11,y, x] = model_1(ni,nj,p,c,d,C1,C2,D1,D2,K,num_k,a1,a2,a3,num_obj);

%% 
[ck, dk] = real_cd(c,d);
n=1;% �������龰
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
