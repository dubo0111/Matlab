%clear all;

%% ��������
% %stage 
% ni = 10;%���������
% nj = 6;%��ѡ��ʩ������
% p = 3;%��ʩ����
% num_k = 3;%�龰����
% sum_kj = 3;%���ƻ���ʩ����������
% %Weights
% a1=0.2;a2=0;a3=1;
% %stage 2  
% pk = p;%��ʩ����
 B = 1;%��ʩ�޽��ɱ�
% R = 1000;%allocation�����ɱ�(|xij - vij|) 
% L_max = 800000;
% n = 1;%ʵ�ʷ������龰


%% 
iteration = 0;
i_end = 1;%ѭ������
result = zeros (i_end,8);
while iteration < i_end
% %% �����������
% xy_demand = randi(100,2,ni);xy_facility = randi(100,2,nj);% ������������Ϳ�ѡ��ʩλ��
% c = distance(xy_demand,xy_facility);%�������(�ɱ�)����
% d = randi(100,ni,1);% �����������
% [ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d );
% [ K ] = scenario_k( sum_kj,num_k,nj );% ��������龰��
% [ck, dk] = real_cd(c,d);% �������stage_2ʵ�ʳɱ�������

%% ����

   tic;
    [ cost1,L_11,L_12,L_13,y1,x1,u1,v1,w1] = location_draw(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,C1,D1,C2,D2,K,ck,dk,n);
    [ cost2,L_21,L_22,L_23,y2,x2,u2,v2,w2] = location_draw_compare(ni,nj,p,num_k,a1,a2,a3,pk,B,R,L_max,c,d,ck,dk,K,C1,C2,D1,D2,n);
    iteration = iteration + 1;
    result(iteration,:) = [L_11,L_12,L_13,cost1,L_21,L_22,L_23,cost2];
    %clearvars L_11 L_12 L_13 y1 x1 u1 v1 c d ck dk K C1 C2 D1 D2 L_21 L_22 L_23 y2 x2 u2 v2
    clear global
    clear functions %��պ����ӿ������ٶȣ�����cplex��yalmip�ۻ���һ��ȫ�ֱ���LUbounds���ڴ�ռ��Խ��Խ��)
    time = toc;
    show = ['��',num2str(iteration),'�μ��㻨��ʱ��',num2str(round(time)),'s'];
    disp(show);
    result(iteration,:)
    draw
    
end
a = ['�������  �� �� ',num2str(i_end),' �� !  �������'];disp(a)
%  filename = ['result_',num2str(i_end),'_ni=',num2str(ni),'_nj=',num2str(nj),'_p=',num2str(p),'_numk=',num2str(num_k),'_a1a2a3=',num2str(a1),num2str(a2),num2str(a3),num2str(now),'.xls'];
%  %xlswrite(filename,result);
%  %run

