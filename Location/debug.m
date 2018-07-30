clear
ni = 4;%需求点数量
nj = 4;%可选设施点数量
p = 2;%设施限制
num_k = 1;%情景数量
sum_kj = 1;%被破坏设施点数量上限
a1=1;a2=1;a3=1;
c = randi(100,ni,nj);%成本矩阵
d = randi(100,ni,1);%需求矩阵
[ C1,C2,D1,D2 ] = scenario_cd( num_k,c,d );
[ K ] = scenario_k( sum_kj,num_k,nj );
num_obj = 2;

% for i = 1:ni
%   for j = 1:nj
%     x(i,j) <= y(j)
%   end
% end
% 
% %(2)sum of xij = 1
% for i = 1:ni
%   sum(x(i,:)) == 1
% end
% 
% %(3)sum y < p
% sum(y) <= p
% 
% %(4)L1 >= cdx
% cdx = 0;
% for i = 1:ni
%   for j= 1:nj
%     cdx = cdx+c(i,j)*d(i)*x(i,j);
%   end
%   %L1 >= cdx
%   cdx
%   cdx=0;
% end
% end