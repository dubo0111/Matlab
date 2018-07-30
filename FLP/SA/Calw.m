function [ wf ] = Calw( )
c=xlsread('C6-10.xlsx');
f=xlsread('flow.xlsx');
for i=1:size(c)
    for j=1:size(c)
        if i==j
            c(i,j)=0;f(i,j)=0;
        end
    end
end
a=size(f,1);
c1=2*c/sum(sum(c));f1=2*f/sum(sum(f));
c2=reshape(c1,1,a^2);f2=reshape(f1,1,a^2);
stdf=std(f2);stdc=std(c2);
wf=stdf/(stdf+stdc);
end

