function [c,d,C1,D1,K] = data_city49(num_k, sum_kj )

% %需求点（设施点）数量，情景数量，被破坏设施点数量上限，
% %ni = 5;num_k = 3;sum_kj = 2;
% xy_demand = randi(100,2,ni); %随机生成需求点和可选设施位置
% c = distance(xy_demand);%计算距离(成本)矩阵
% d = randi(100,ni,1);% 随机生成需求
% % 随机生成情景集
% [ C1,~,D1,~ ] = scenario_cd( num_k,c,d );    %!!!!!!!!!需求的生成方式？
% [ K ] = scenario_k( sum_kj,num_k,ni );
load city_49;ni = 49;
location = city_49(1:49, 2:3);location = cell2mat(location);
c = distance(location');
d = city_49(1:49,4);d = cell2mat(d); 
[ C1,~,D1,~ ] = scenario_cd( num_k,c,d );  
[ K ] = scenario_k( sum_kj,num_k,ni );
%save('save.mat');

end







