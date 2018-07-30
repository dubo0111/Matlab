function [ga]=genetic_algorithm(DL442,city442)

CityNum=30;
%  dislist=DL442;
%  Clist=city442;
 [dislist,Clist]=tsp(CityNum);


inn=100; %初始种群大小
gnmax=100;  %最大代数
pc=0.8; %交叉概率
pm=0.8; %变异概率

%产生初始种群
for i=1:inn
    s(i,:)=randperm(CityNum);
end
[f,p]=objf(s,dislist);

gn=1;
while gn<gnmax+1
   for j=1:2:inn
      seln=sel(s,p);  %选择操作
      scro=cro(s,seln,pc);  %交叉操作
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      smnew(j,:)=mut(scnew(j,:),pm);  %变异操作
      smnew(j+1,:)=mut(scnew(j+1,:),pm);
   end
   s=smnew;  %产生了新的种群
   [f,p]=objf(s,dislist);  %计算新种群的适应度
   %记录当前代最好和平均的适应度
   [fmax,nmax]=max(f);
   ymean(gn)=1000/mean(f);
   ymax(gn)=1000/fmax;
   %记录当前代的最佳个体
   x=s(nmax,:);
   drawTSP(Clist,x,ymax(gn),gn,0);
   gn=gn+1;
   %pause;
end
gn=gn-1;

figure(2);
plot(ymax,'r'); hold on;
plot(ymean,'b');grid;
title('搜索过程');
legend('最优解','平均解');
end

%------------------------------------------------
%计算适应度函数
function [f,p]=objf(s,dislist);

inn=size(s,1);  %读取种群大小
for i=1:inn
   f(i)=CalDist(dislist,s(i,:));  %计算函数值，即适应度
end
f=1000./f';
%计算选择概率
fsum=0;
for i=1:inn
   fsum=fsum+f(i)^15;
end
for i=1:inn
   ps(i)=f(i)^15/fsum;
end
%计算累积概率
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
%“选择”操作
function seln=sel(s,p);

inn=size(p,1);
%从种群中选择两个个体
for i=1:2
   r=rand;  %产生一个随机数
   prand=p-r;
   j=1;
   while prand(j)<0
       j=j+1;
   end
   seln(i)=j; %选中个体的序号
end
end

%------------------------------------------------
%“交叉”操作
function scro=cro(s,seln,pc);

bn=size(s,2);
pcc=pro(pc);  %根据交叉概率决定是否进行交叉操作，1则是，0则否
scro(1,:)=s(seln(1),:);
scro(2,:)=s(seln(2),:);
if pcc==1
   c1=round(rand*(bn-2))+1;  %在[1,bn-1]范围内随机产生一个交叉位
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
%“变异”操作
function snnew=mut(snew,pm);

bn=size(snew,2);
snnew=snew;

pmm=pro(pm);  %根据变异概率决定是否进行变异操作，1则是，0则否
if pmm==1
   c1=round(rand*(bn-2))+1;  %在[1,bn-1]范围内随机产生一个变异位
   c2=round(rand*(bn-2))+1;
   chb1=min(c1,c2);
   chb2=max(c1,c2);
   x=snew(chb1+1:chb2);
   snnew(chb1+1:chb2)=fliplr(x);
end
end