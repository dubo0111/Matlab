clear;
% 
% ��������
%stage 1
ni = 8;%���������
nj = 6;%��ѡ��ʩ������
p = 3;%��ʩ����
num_k = 3;%�龰����
sum_kj = 3;%���ƻ���ʩ����������
%Weights
a1=0.2;a2=0.2;a3=1;
%stage 2  
pk = p;%��ʩ����
B = 20000;%��ʩ�޽��ɱ�
R = 1000;%allocation�����ɱ�(|xij - vij|) 
L_max = 800000;
%% 
%L_11 = 0;L_21 = 0;L1_diff = L_11 - L_21;
iteration = 0;
i_end = 1;%ѭ������
result = zeros (i_end,6);
%while L1_diff == 0 && iteration <=100
while iteration < i_end
%         ni = 8;%���������
%         nj = 6;%��ѡ��ʩ������
%         p = 3;%��ʩ����
%         num_k = 3;%�龰����
%         sum_kj = 3;%���ƻ���ʩ����������
%         %Weights
%         a1=0.2;a2=0.2;a3=1;
%         %stage 2  
%         pk = p;%��ʩ����
%         B = 20000;%��ʩ�޽��ɱ�
%         R = 1000;%allocation�����ɱ�(|xij - vij|) 
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
    show = ['��',num2str(iteration),'�μ��㻨��ʱ��',num2str(round(time)),'s'];
    disp(show);
    result(iteration,:)
end
a = ['�������  �� �� ',num2str(i_end),' �� !  �������'];disp(a)
filename = ['\data\result_',num2str(i_end),'_ni=',num2str(ni),'_nj=',num2str(nj),'_p=',num2str(p),'_numk=',num2str(num_k),'_a1a2a3=',num2str(a1),num2str(a2),num2str(a3),num2str(now),'.xls'];
xlswrite(filename,result);

