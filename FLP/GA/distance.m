function [ distance] =distance
axis=cell(19,29);%��ʼ���������
axis1=[];
distance=zeros(383,383);
%% ȷ����Ҫ�̶�λ�õ�facility
%�������̶���facility�����꣬����Ϊ���ĵ�
axis1=xlsread('Position_fixed.xlsx');
for i=1:383
    for j=1:383
        distance(i,j)=abs(axis1(i,1)-axis1(j,1))+abs(axis1(i,2)-axis1(j,2));
    end
end

%% �̶�λ��ǰ
%ԭʼ�������

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
% %�γɶ�Ӧ�������
% n=1;
% for i=1:19
%     for j=1:29     
%         if isempty(axis{i,j})==0
%         axis1{n,1}=axis{i,j};
%         n=n+1;
%         end
%     end
% end

%�ֿ�������
% for i=1:383
%     for j=1:383
%         distance(i,j)=abs(axis1{i,1}(1)-axis1{j,1}(1))+abs(axis1{i,1}(2)-axis1{j,1}(2));
%     end
% end
%λ�ñ��
% for i=1:383
%     IndexP(i,1)=axis1{i,1}(1);IndexP(i,2)=axis1{i,1}(2);
% end
% end


