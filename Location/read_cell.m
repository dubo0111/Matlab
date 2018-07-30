function [ K] = read_cell( name,num_k,num )
if num == 1%读取情景K
    A = xlsread(name);
    for i =1:num_k
        K{i} = A(i,:);
    end
end
if num == 2 %读取C
    A = xlsread(name);
    [~,q] = size(A);nj = q/num_k;
    for i =1:num_k
        ii = nj*(i-1)+1;
        K{i} = A(:,ii:ii+nj-1);
    end
end
if num == 3 %读取D
    A = xlsread(name);
    for i =1:num_k
        K{i} = A(:,i);
    end
end


end