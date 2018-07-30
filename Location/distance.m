function [ c ] = distance( xyd,xyf )
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here
[~,ni] = size(xyd);
[~,nj] = size(xyf);
c = zeros(ni,nj);
for i = 1:ni
   for j = 1:nj
       c(i,j) = sqrt((xyd(1,i)-xyf(1,j))^2 + (xyd(2,i)-xyf(2,j))^2);
   end
end

end

