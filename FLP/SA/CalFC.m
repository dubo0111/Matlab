function [ fc ] = CalFC(a )
%根据权重计算价值系数

c=xlsread('C6-10.xlsx');
f=xlsread('flow.xlsx');
%处理c
for i=1:size(c)
    for j=1:size(c)
        if i==j
            c(i,j)=0;
        end
%         if c(i,j)==100;
%             c(i,j)=6;
%         end
    end
end
c1=c/sum(sum(c));f1=f/sum(sum(f));
%c1=c1*10^7;f1=f1*10^7;
fc=(a.*f1)+((1-a).*c1);
for i=325:343
    fc(i,:)=0;fc(:,i)=0;
end
for i=345:371
    fc(i,:)=0;fc(:,i)=0;
end
for i=373:383
    fc(i,:)=0;fc(:,i)=0;
end

%xlswrite('fc08.xlsx',fc);
end

