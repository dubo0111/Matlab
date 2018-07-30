close all;
clear all; 

%% General settings: 
N = 28
x = randn(N, 1); 
y = 0.6*x + 0.3*randn(N, 1); 

xMin = min(x(:)) 
xMax = max(x(:)) 
yMin = min(y(:)) 
yMax = max(y(:)) 

windowChoice = ...
    [xMin*1.2-xMax*0.2, ...
     xMax*1.2-xMin*0.2, ...
     yMin*1.2-yMax*0.2, ...
     yMax*1.2-xMin*0.2]; 


%% First demo; 
% All nodes get the same size (no size specified)
% All individual each get a unique color: 

figure; 
subplot(1,3,1); 
bubbleGum(x, y); 
drawnow; axis(windowChoice); 

% %% Second demo sizes are specified: 
% relSizes = round(5+300*rand(N, 1).^(1.5)); 
% 
% subplot(1,3,2); 
% bubbleGum(x, y, relSizes); 
% drawnow; axis(windowChoice); 
% 
% 
% 
% %% Third demo; 
% % Nodes are grouped (two groups) 
% labels = ceil(3*rand(N, 1));
% 
% subplot(1,3,3); axis(windowChoice); 
% bubbleGum(x, y, relSizes, labels); 
% drawnow; axis(windowChoice); 

