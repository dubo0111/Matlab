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

% %最多可能有多少种情景
% total_num_k = 0;
% for i = 1:sum_kj
%     total_num_k = total_num_k+nchoosek(nj,i);
% end
% 
% %num_k的逻辑判断与修正
% if num_k >= 1 
%     if num_k >= total_num_k
%         disp('*********************');disp('num_k超出上限！按最大值计算。');disp('*********************');
%         num_k = total_num_k;
%     end
% elseif num_k==0
%     num_k = total_num_k;
% else
%     disp('*********************');disp('num_k < 0 !');disp('*********************');
%     return
% end

% 生成情景集(设施破坏情景，所有可能性)
% 方案一：考虑所有情况；方案二：随意任意生成
%方案一：
% k = zeros(1,nj);
% for i = 1:sum_kj %
%     
%     for j = 1:nj
%         
%         
%     end    
% end

%方案二:
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

