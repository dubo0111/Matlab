function [f,p]=obj(s1,dislist,fc)

inn=size(s1,1);  %��ȡ��Ⱥ��С
for i=1:inn
   f(i)=CalF(dislist,s1(i,:),fc);  %���㺯��ֵ������Ӧ��
end
f=1000./f';
%����ѡ�����
fsum=0;
for i=1:inn
   fsum=fsum+f(i)^20;
end
for i=1:inn
   ps(i)=f(i)^20/fsum;
end
%�����ۻ�����
p(1)=ps(1);
for i=2:inn
   p(i)=p(i-1)+ps(i);
end
p=p';
end


