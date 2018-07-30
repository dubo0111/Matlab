function [c,d,C1,D1,K] = data_generation(ni, num_k, sum_kj)

%需求点（设施点）数量，情景数量，被破坏设施点数量上限，
%ni = 5;num_k = 3;sum_kj = 2;
xy_demand = randi(100,2,ni); %随机生成需求点和可选设施位置
c = distance(xy_demand);%计算距离(成本)矩阵
d = randi(100,ni,1);% 随机生成需求
% 随机生成情景集
[ C1,~,D1,~ ] = scenario_cd( num_k,c,d );    %!!!!!!!!!需求的生成方式？
[ K ] = scenario_k( sum_kj,num_k,ni );

%% export data
% EXCEL FILE
% xlswrite('\data\c.xls',c);xlswrite('\data\d.xls',d);
% for i = 1:num_k
%     nameC = ['\data\C1_',num2str(i),'.xls'];xlswrite(nameC,C1{i});
%     nameD = ['\data\D1_',num2str(i),'.xls'];xlswrite(nameD,D1{i});
%     nameK = ['\data\K1_',num2str(i),'.xls'];xlswrite(nameK,K{i});
% end

% MAT File
% nj = ni; y =[1 1 1 0 0 ];
save('save.mat');

end







