function [ K ] = scenario_k( sum_kj,num_k,nj )
%SCENARIO Scenario Generator for Disruption Set
%function [ k ] = scenario( sum_kj,num_k )
% num_k:情景数量上限,n=0时表示不设上限
% sum_kj:一个情景中被破坏设施数量上限
% nj:设施点数量

%sum_kj判断
if sum_kj >=1
    if sum_kj >= nj
        disp('*********************');disp('sum_k超出上限！');disp('*********************');
        return
    end
else
    disp('*********************');disp('sum_kj < 1！');disp('*********************');
    return
end

k = zeros(1,nj);K = cell(1,num_k);
for i = 1:num_k;
    rand_kj = randperm(nj);
    rand_k = rand_kj(1,1:sum_kj);
    for j = 1:sum_kj
          k(rand_k(j)) = 1; 
    end
   K{i} = k;
   k = zeros(1,nj);
end



end

