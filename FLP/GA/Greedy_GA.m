function Greedy_GA
Num=323;
dislist=xlsread('distance.xlsx');
% fc=xlsread('fc08.xlsx');
fc=CalFC(0.8);%
position=xlsread('Position.xlsx');
indexfc=xlsread('Facility.xlsx');
% ini=xlsread('initial1.0.xlsx');ini=ini';
% [dislist,Clist]=tsp(CityNum);

inn=100; %初始种群大小
gnmax=100000;  %最大代数
pc=0.2; %交叉概率
pm=0.2; %变异概率
a=0.8;%目标函数权重
%生成固定染色体序列
fixedDNA=zeros(1,60);
for i=324:383
    fixedDNA(1,i-323)=i;
end
%产生初始种群
%因为存在固定位置的区域，可分段产生随机数
%!!可使所有固定位置放在最后
%% 随机生成初始种群
s=zeros(inn,Num);
for i=1:inn
    s(i,:)=randperm(Num);
end
%  s(1,:)=ini(1,1:size(s,2));
s1=s;
for i=1:inn%植入固定染色体
    for j=1:size(fixedDNA,2)
    s1(i,size(s,2)+j)=fixedDNA(j);
    end
end
%可向种群中插入初始布局解
%  s1(1,:)=ini;
[f,p]=obj(s1,dislist,fc);
gn=1;
tic;
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
%    if mod(gn,100)==0
%        s(1,:)=ini(1,1:size(s,2));
%     end
    s1=s;
    for i=1:inn%植入固定染色体
        for j=1:size(fixedDNA,2)
        s1(i,size(s,2)+j)=fixedDNA(j);
        end
    end
   [f,p]=obj(s1,dislist,fc);  %计算新种群的适应度
   %记录当前代最好和平均的适应度
      [fmax,nmax]=max(f);
      ymean(gn)=1000/mean(f);
      ymax(gn)=1000/fmax;
%    [fmax,nmax]=max(f);
%    ymean(gn)=1000/mean(f);
%    ymax(gn)=1000/fmax;
   %记录当前代的最佳个体
   x=s1(nmax,:);
%    drawTSP(Clist,x,ymax(gn),gn,0);
       draw(x,position,indexfc,gn,fmax);
       draw2(ymax,ymean);
   gn=gn+1;
   %pause;
end
gn=gn-1;
% ymax
end

%--------------------------------------------------
%“选择”操作
function seln=sel(s,p)
% c1=fix(unifrnd(1,size(s,1)+1));
% seln(1)=c1;
% c2=c1;
% while c2==c1
% c2=fix(unifrnd(1,size(s,1)+1));
% end
% seln(2)=c2;

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
%--------------------------------------------------
function pcc=pro(pc)

test(1:100)=0;
l=round(100*pc);
test(1:l)=1;
n=round(rand*99)+1;
pcc=test(n);   
end
%------------------------------------------------
%“交叉”操作
function scro=cro(s,seln,pc)

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
           zhi= scro(2,1:chb2)==scro(2,i);
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
   snnew(chb1+1:chb2)=fliplr(x);%翻转
end
end