clear;

CityNum=30;
[dislist,Clist]=tsp(CityNum);

Tlist=zeros(CityNum);%禁忌表(tabu list)
cl=100;%保留前cl个最好候选解
bsf=Inf;
tl=50; %禁忌长度(tabu length)
l1=200;%候选解(candidate),不大于n*(n-1)/2(全部领域解个数)
S0=randperm(CityNum);
S=S0;
BSF=S0;
Si=zeros(l1,CityNum);
StopL=2000; %终止步数
p=1;
clf;
figure(1);

while (p<StopL+1)
    if l1>CityNum*(CityNum)/2
        disp('候选解个数,不大于n*(n-1)/2(全部领域解个数)！ 系统自动退出！');
        l1=(CityNum*(CityNum)/2)^.5;
        break;
    end
    ArrS(p)=CalDist(dislist,S);        
    i=1;
    A=zeros(l1,2);
    while i<=l1        
        M=CityNum*rand(1,2);
        M=ceil(M);
        if M(1)~=M(2)
            m1=max(M(1),M(2));m2=min(M(1),M(2));
            A(i,1)=m1;A(i,2)=m2;
            if i==1
                isdel=0;
            else
                for j=1:i-1
                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)
                        isdel=1;
                        break;
                    else
                        isdel=0;
                    end
                end
            end
            if ~isdel
                i=i+1;
            else
                i=i;
            end
        else 
            i=i;
        end
    end
    
    for i=1:l1
        Si(i,:)=S;
        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]);
        CCL(i,1)=i;
        CCL(i,2)=CalDist(dislist,Si(i,:));
        CCL(i,3)=S(A(i,1));
        CCL(i,4)=S(A(i,2));   
    end
    [fs fin]=sort(CCL(:,2));
    for i=1:cl
        CL(i,:)=CCL(fin(i),:);
    end
    
    if CL(1,2)<bsf  %藐视准则(aspiration criterion)
        bsf=CL(1,2);
        S=Si(CL(1,1),:);        
        BSF=S;
        for m=1:CityNum
            for n=1:CityNum
                if Tlist(m,n)~=0
                    Tlist(m,n)=Tlist(m,n)-1;
                end
            end
        end
        Tlist(CL(1,3),CL(1,4))=tl;
    else  
        for i=1:cl
            if Tlist(CL(i,3),CL(i,4))==0
                S=Si(CL(i,1),:);
                for m=1:CityNum
                    for n=1:CityNum
                        if Tlist(m,n)~=0
                            Tlist(m,n)=Tlist(m,n)-1;
                        end
                    end
                end
                Tlist(CL(i,3),CL(i,4))=tl;
                break;
            end
        end
    end
    
    Arrbsf(p)=bsf;
    drawTSP(Clist,BSF,bsf,p,0);
    p=p+1;
end
BestShortcut=BSF
theMinDistance=bsf

figure(2);
plot(Arrbsf,'r'); hold on;
plot(ArrS,'b');grid;
title('搜索过程');
legend('最优解','当前解');