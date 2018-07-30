function [ K ] = scenario_k( sum_kj,num_k,nj )
%SCENARIO Scenario Generator for Disruption Set
%function [ k ] = scenario( sum_kj,num_k )
% num_k:�龰��������,n=0ʱ��ʾ��������
% sum_kj:һ���龰�б��ƻ���ʩ��������
% nj:��ʩ������

%sum_kj�ж�
if sum_kj >=1
    if sum_kj >= nj
        disp('*********************');disp('sum_k�������ޣ�');disp('*********************');
        return
    end
else
    disp('*********************');disp('sum_kj < 1��');disp('*********************');
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

