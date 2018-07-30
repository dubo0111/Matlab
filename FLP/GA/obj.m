function [f,p]=obj(s1,dislist,fc)

inn=size(s1,1);  %读取种群大小
for i=1:inn
   f(i)=CalF(dislist,s1(i,:),fc);  %计算函数值，即适应度
end
f=1000./f';
%计算选择概率
fsum=0;
for i=1:inn
   fsum=fsum+f(i)^20;
end
for i=1:inn
   ps(i)=f(i)^20/fsum;
end
%计算累积概率
p(1)=ps(1);
for i=2:inn
   p(i)=p(i-1)+ps(i);
end
p=p';
end


