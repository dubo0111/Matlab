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

% %�������ж������龰
% total_num_k = 0;
% for i = 1:sum_kj
%     total_num_k = total_num_k+nchoosek(nj,i);
% end
% 
% %num_k���߼��ж�������
% if num_k >= 1 
%     if num_k >= total_num_k
%         disp('*********************');disp('num_k�������ޣ������ֵ���㡣');disp('*********************');
%         num_k = total_num_k;
%     end
% elseif num_k==0
%     num_k = total_num_k;
% else
%     disp('*********************');disp('num_k < 0 !');disp('*********************');
%     return
% end

% �����龰��(��ʩ�ƻ��龰�����п�����)
% ����һ�����������������������������������
%����һ��
% k = zeros(1,nj);
% for i = 1:sum_kj %
%     
%     for j = 1:nj
%         
%         
%     end    
% end

%������:
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

