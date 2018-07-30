function [] = Main_Function( iter,count,num_k)
%MAIN_FUCTION Summary of this function goes here
%   Detailed explanation goes here
%load test
%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 1; %
UB_LB = 0; e_now = 1e-5; % Stopping Criterion
kr = 1;

%% Data
%需求点（设施点）数量，设施限制，情景数量，被破坏设施点数量上限，权重1,2
if iter <=3
    ni = 25;nj = ni;p = 8;sum_kj = 4;%a1=0.2;a2=0.8;num_k = 4;
    [c,d,C1,D1,K] = data_city25(num_k,sum_kj);
elseif iter>3 && iter<=6
    ni = 49;nj = ni;p = 8;sum_kj = 4;%a1=0.2;a2=0.8;num_k = 4;
    [c,d,C1,D1,K] = data_city49(num_k,sum_kj);
else
    ni=3;nj=ni;p=2;sum_kj=1;
    [c,d,C1,D1,K] = data_generation(ni, num_k, sum_kj);
end
if iter == 2 || iter == 5
    a1 = 0.5;a2=0.5;
elseif iter == 1 || iter == 4
    a1=0.2;a2=0.8;
elseif iter == 3 || iter == 6
    a1= 0.8;a2=0.2;
else
    a1 = 0.5;a2=0.5;
end


%c*d;c1*d1
for i = 1:ni
    for j = 1:nj
        CD (i,j) = c(i,j)*d(i);
    end
end
for k = 1:num_k
    for i = 1:ni
        for j = 1:nj
            CD1{k}(i,j) = C1{k}(i,j)*D1{k}(i);
            %CD1{k}=CD1{k}/(1e8);
        end
    end
end
save test;
%save all data
count
filename = ['C:\Users\n15075\Google Drive\Matlab\Location_RO_12\2S_p-median\data\test',num2str(count),'.mat'];
save(filename)


% toc




end

