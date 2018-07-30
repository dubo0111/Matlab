function [ c ] = distance( xyd )
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here
[~,ni] = size(xyd);
c = zeros(ni,ni);
for i = 1:ni
   for j = 1:ni
       c(i,j) = sqrt((xyd(1,i)-xyd(1,j))^2 + (xyd(2,i)-xyd(2,j))^2);
   end
end

end

