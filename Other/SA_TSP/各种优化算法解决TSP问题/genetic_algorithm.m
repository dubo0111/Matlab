function [ga]=genetic_algorithm(DL442,city442)

CityNum=30;
%  dislist=DL442;
%  Clist=city442;
 [dislist,Clist]=tsp(CityNum);


inn=100; %��ʼ��Ⱥ��С
gnmax=100;  %������
pc=0.8; %�������
pm=0.8; %�������

%������ʼ��Ⱥ
for i=1:inn
    s(i,:)=randperm(CityNum);
end
[f,p]=objf(s,dislist);

gn=1;
while gn<gnmax+1
   for j=1:2:inn
      seln=sel(s,p);  %ѡ�����
      scro=cro(s,seln,pc);  %�������
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      smnew(j,:)=mut(scnew(j,:),pm);  %�������
      smnew(j+1,:)=mut(scnew(j+1,:),pm);
   end
   s=smnew;  %�������µ���Ⱥ
   [f,p]=objf(s,dislist);  %��������Ⱥ����Ӧ��
   %��¼��ǰ����ú�ƽ������Ӧ��
   [fmax,nmax]=max(f);
   ymean(gn)=1000/mean(f);
   ymax(gn)=1000/fmax;
   %��¼��ǰ������Ѹ���
   x=s(nmax,:);
   drawTSP(Clist,x,ymax(gn),gn,0);
   gn=gn+1;
   %pause;
end
gn=gn-1;

figure(2);
plot(ymax,'r'); hold on;
plot(ymean,'b');grid;
title('��������');
legend('���Ž�','ƽ����');
end

%------------------------------------------------
%������Ӧ�Ⱥ���
function [f,p]=objf(s,dislist);

inn=size(s,1);  %��ȡ��Ⱥ��С
for i=1:inn
   f(i)=CalDist(dislist,s(i,:));  %���㺯��ֵ������Ӧ��
end
f=1000./f';
%����ѡ�����
fsum=0;
for i=1:inn
   fsum=fsum+f(i)^15;
end
for i=1:inn
   ps(i)=f(i)^15/fsum;
end
%�����ۻ�����
p(1)=ps(1);
for i=2:inn
   p(i)=p(i-1)+ps(i);
end
p=p';
end

%--------------------------------------------------
function pcc=pro(pc);

test(1:100)=0;
l=round(100*pc);
test(1:l)=1;
n=round(rand*99)+1;
pcc=test(n);   
end

%--------------------------------------------------
%��ѡ�񡱲���
function seln=sel(s,p);

inn=size(p,1);
%����Ⱥ��ѡ����������
for i=1:2
   r=rand;  %����һ�������
   prand=p-r;
   j=1;
   while prand(j)<0
       j=j+1;
   end
   seln(i)=j; %ѡ�и�������
end
end

%------------------------------------------------
%�����桱����
function scro=cro(s,seln,pc);

bn=size(s,2);
pcc=pro(pc);  %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0���
scro(1,:)=s(seln(1),:);
scro(2,:)=s(seln(2),:);
if pcc==1
   c1=round(rand*(bn-2))+1;  %��[1,bn-1]��Χ���������һ������λ
   c2=round(rand*(bn-2))+1;
   chb1=min(c1,c2);
   chb2=max(c1,c2);
   middle=scro(1,chb1+1:chb2);
   scro(1,chb1+1:chb2)=scro(2,chb1+1:chb2);
   scro(2,chb1+1:chb2)=middle;
   for i=1:chb1
       while find(scro(1,chb1+1:chb2)==scro(1,i))
           zhi=find(scro(1,chb1+1:chb2)==scro(1,i));
           y=scro(2,chb1+zhi);
           scro(1,i)=y;
       end
       while find(scro(2,chb1+1:chb2)==scro(2,i))
           zhi=find(scro(2,chb1+1:chb2)==scro(2,i));
           y=scro(1,chb1+zhi);
           scro(2,i)=y;
       end
   end
   for i=chb2+1:bn
       while find(scro(1,1:chb2)==scro(1,i))
           zhi=find(scro(1,1:chb2)==scro(1,i));
           y=scro(2,zhi);
           scro(1,i)=y;
       end
       while find(scro(2,1:chb2)==scro(2,i))
           zhi=find(scro(2,1:chb2)==scro(2,i));
           y=scro(1,zhi);
           scro(2,i)=y;
       end
   end
end
end

%--------------------------------------------------
%�����족����
function snnew=mut(snew,pm);

bn=size(snew,2);
snnew=snew;

pmm=pro(pm);  %���ݱ�����ʾ����Ƿ���б��������1���ǣ�0���
if pmm==1
   c1=round(rand*(bn-2))+1;  %��[1,bn-1]��Χ���������һ������λ
   c2=round(rand*(bn-2))+1;
   chb1=min(c1,c2);
   chb2=max(c1,c2);
   x=snew(chb1+1:chb2);
   snnew(chb1+1:chb2)=fliplr(x);
end
end