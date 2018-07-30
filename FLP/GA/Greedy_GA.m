function Greedy_GA
Num=323;
dislist=xlsread('distance.xlsx');
% fc=xlsread('fc08.xlsx');
fc=CalFC(0.8);%
position=xlsread('Position.xlsx');
indexfc=xlsread('Facility.xlsx');
% ini=xlsread('initial1.0.xlsx');ini=ini';
% [dislist,Clist]=tsp(CityNum);

inn=100; %��ʼ��Ⱥ��С
gnmax=100000;  %������
pc=0.2; %�������
pm=0.2; %�������
a=0.8;%Ŀ�꺯��Ȩ��
%���ɹ̶�Ⱦɫ������
fixedDNA=zeros(1,60);
for i=324:383
    fixedDNA(1,i-323)=i;
end
%������ʼ��Ⱥ
%��Ϊ���ڹ̶�λ�õ����򣬿ɷֶβ��������
%!!��ʹ���й̶�λ�÷������
%% ������ɳ�ʼ��Ⱥ
s=zeros(inn,Num);
for i=1:inn
    s(i,:)=randperm(Num);
end
%  s(1,:)=ini(1,1:size(s,2));
s1=s;
for i=1:inn%ֲ��̶�Ⱦɫ��
    for j=1:size(fixedDNA,2)
    s1(i,size(s,2)+j)=fixedDNA(j);
    end
end
%������Ⱥ�в����ʼ���ֽ�
%  s1(1,:)=ini;
[f,p]=obj(s1,dislist,fc);
gn=1;
tic;
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
%    if mod(gn,100)==0
%        s(1,:)=ini(1,1:size(s,2));
%     end
    s1=s;
    for i=1:inn%ֲ��̶�Ⱦɫ��
        for j=1:size(fixedDNA,2)
        s1(i,size(s,2)+j)=fixedDNA(j);
        end
    end
   [f,p]=obj(s1,dislist,fc);  %��������Ⱥ����Ӧ��
   %��¼��ǰ����ú�ƽ������Ӧ��
      [fmax,nmax]=max(f);
      ymean(gn)=1000/mean(f);
      ymax(gn)=1000/fmax;
%    [fmax,nmax]=max(f);
%    ymean(gn)=1000/mean(f);
%    ymax(gn)=1000/fmax;
   %��¼��ǰ������Ѹ���
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
%��ѡ�񡱲���
function seln=sel(s,p)
% c1=fix(unifrnd(1,size(s,1)+1));
% seln(1)=c1;
% c2=c1;
% while c2==c1
% c2=fix(unifrnd(1,size(s,1)+1));
% end
% seln(2)=c2;

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
%--------------------------------------------------
function pcc=pro(pc)

test(1:100)=0;
l=round(100*pc);
test(1:l)=1;
n=round(rand*99)+1;
pcc=test(n);   
end
%------------------------------------------------
%�����桱����
function scro=cro(s,seln,pc)

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
           zhi= scro(2,1:chb2)==scro(2,i);
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
   snnew(chb1+1:chb2)=fliplr(x);%��ת
end
end