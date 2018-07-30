function [  ] = data(a1,a2, num_k ,p, sum_kj, city)
%DATA Summary of this function goes here
%   Detailed explanation goes here
% Data
%需求点（设施点）数量，设施限制，情景数量，被破坏设施点数量上限，权重1,2
if city == 25
    ni = 25;nj = ni;%a1=0.5;a2=0.5;
    %num_k = 5;p = 8;sum_kj = 4
    [c,d,C1,D1,K] = data_city25 ( num_k,sum_kj);
elseif city==49
    ni = 49;nj = ni;
    [c,d,C1,D1,K] = data_city49 ( num_k,sum_kj);
else
    ni=city;nj=ni;
    [c,d,C1,D1,K] = data_generation(ni, num_k, sum_kj);
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
%CD=CD/(1e8);
%clear c C1 d D1 i j k sum_kj
save test1

end

