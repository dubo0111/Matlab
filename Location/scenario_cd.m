function [ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d)
%SCENARIO Scenario Generator for Cost and Demand
% num_k:�龰��������,n=0ʱ��ʾ��������
% ck����ɱ�����dk�������

[ni,nj] = size(c);
% �����龰��
C1 = cell(1,num_k);C2 = cell(1,num_k);D1 = cell(1,num_k);D2 = cell(1,num_k);
for i = 1:num_k
    rand_c1 = rand(ni,nj)-0.5+1;
    %rand_c2 = rand(ni,nj)-0.5+1;
    rand_d1 = rand(ni,1)-0.5+1;
    rand_d2 = rand(ni,1)-0.5+1;
    c1 = c.*rand_c1;%c2 = c.*rand_c2;
    d1 = d.*rand_d1;d2 = d.*rand_d2;
    C1{i} = c1;%C2{i} = c2;
    D1{i} = d1;D2{i} = d2;
%     C1{i} = c*1.5;C2{i} = c*1.5;
%     D1{i} = d*1.5;D2{i} = d*1.5;
end
    C2 = C1;%�ֺ�����ɱ�����
end

