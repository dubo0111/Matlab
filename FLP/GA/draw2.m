function [ ] = draw2(ymin,ymean)
%DRAW2 Summary of this function goes here
%   Detailed explanation goes here
subplot(2,1,2);
plot(ymin,'r'); hold on;
plot(ymean,'b');grid;
title('搜索过程');
legend('最优解','平均解');
hold off

end

