function [ A ] = convert(  )
%CONVERT Summary of this function goes here
%   Detailed explanation goes here

[~,~,raw] = xlsread('250.xlsx');
[a,~]=size(raw);%a:number of city
A = cell(a,7);
for i = 1:a
    [~,b]=size(raw{i});
    num_column = 1;
    for j = 1:b
        if  raw{i}(j) == '<'
            A{i,num_column} = raw{i}(j:b);
            break
        elseif raw{i}(j) ~= ' '
            A{i,num_column} = [A{i,num_column},raw{i}(j)];
        elseif j~=1 && raw{i}(j-1) ~= ' '
            num_column = num_column+1;
        end
    end
end

for i = 1:a
    for j = 1:6
        A{i,j} = str2double(A{i,j});
    end
end



end

