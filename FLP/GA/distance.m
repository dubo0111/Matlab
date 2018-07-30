function [ distance] =distance
axis=cell(19,29);%初始化坐标矩阵
axis1=[];
distance=zeros(383,383);
%% 确定需要固定位置的facility
%已修正固定的facility的坐标，均改为中心点
axis1=xlsread('Position_fixed.xlsx');
for i=1:383
    for j=1:383
        distance(i,j)=abs(axis1(i,1)-axis1(j,1))+abs(axis1(i,2)-axis1(j,2));
    end
end

%% 固定位置前
%原始坐标矩阵

% for i=1:11
%     for j=1:29
%         axis{i,j}=[i,j];
%     end
% end
% for i=12:19
%     for j=1:8
%     axis{i,j}=[i,j];
%     end
% end
% %形成对应坐标矩阵
% n=1;
% for i=1:19
%     for j=1:29     
%         if isempty(axis{i,j})==0
%         axis1{n,1}=axis{i,j};
%         n=n+1;
%         end
%     end
% end

%仓库距离矩阵
% for i=1:383
%     for j=1:383
%         distance(i,j)=abs(axis1{i,1}(1)-axis1{j,1}(1))+abs(axis1{i,1}(2)-axis1{j,1}(2));
%     end
% end
%位置标号
% for i=1:383
%     IndexP(i,1)=axis1{i,1}(1);IndexP(i,2)=axis1{i,1}(2);
% end
% end


