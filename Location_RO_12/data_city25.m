function [c,d,C1,D1,K] = data_city25(num_k, sum_kj )

% %����㣨��ʩ�㣩�������龰���������ƻ���ʩ���������ޣ�
% %ni = 5;num_k = 3;sum_kj = 2;
% xy_demand = randi(100,2,ni); %������������Ϳ�ѡ��ʩλ��
% c = distance(xy_demand);%�������(�ɱ�)����
% d = randi(100,ni,1);% �����������
% % ��������龰��
% [ C1,~,D1,~ ] = scenario_cd( num_k,c,d );    %!!!!!!!!!��������ɷ�ʽ��
% [ K ] = scenario_k( sum_kj,num_k,ni );
load('C:\Users\n15075\Google Drive\Matlab\Location_RO_12\data\city_25.mat');ni = 25;
location = city_25(1:25, 2:3);location = cell2mat(location);
c = distance(location');
d = city_25(1:25,4);d = cell2mat(d); 
[ C1,~,D1,~ ] = scenario_cd( num_k,c,d );  
[ K ] = scenario_k( sum_kj,num_k,ni );
%save('save.mat');

end







