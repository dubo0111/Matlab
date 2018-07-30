%初始化
clear;

Alpha=1; %信息素重要程度的参数
Beta=5; %启发式因子重要程度的参数 
Rho=0.5; %信息素蒸发系数
NC_max=200; %最大迭代次数
Q=100; %信息素增加强度系数
CityNum=30;  %问题的规模（城市个数）
[dislist,Clist]=tsp(CityNum);
m=CityNum; %蚂蚁个数
Eta=1./dislist;%Eta为启发因子，这里设为距离的倒数
Tau=ones(CityNum,CityNum);%Tau为信息素矩阵
Tabu=zeros(m,CityNum);%存储并记录路径的生成
NC=1;%迭代计数器
R_best=zeros(NC_max,CityNum); %各代最佳路线
L_best=inf.*ones(NC_max,1);%各代最佳路线的长度
L_ave=zeros(NC_max,1);%各代路线的平均长度

figure(1);
while NC<=NC_max %停止条件之一：达到最大迭代次数
    %将m只蚂蚁放到CityNum个城市上
    Randpos=[];
    for i=1:(ceil(m/CityNum))
        Randpos=[Randpos,randperm(CityNum)];
    end
    Tabu(:,1)=(Randpos(1,1:m))';
    
    %m只蚂蚁按概率函数选择下一座城市，完成各自的周游
    for j=2:CityNum
        for i=1:m
            visited=Tabu(i,1:(j-1)); %已访问的城市
            J=zeros(1,(CityNum-j+1));%待访问的城市
            P=J;%待访问城市的选择概率分布
            Jc=1;
            for k=1:CityNum
                if length(find(visited==k))==0
                    J(Jc)=k;
                    Jc=Jc+1;
                end
            end
            %计算待选城市的概率分布
            for k=1:length(J)
                P(k)=(Tau(visited(end),J(k))^Alpha)*(Eta(visited(end),J(k))^Beta);
            end
            P=P/(sum(P));
            %按概率原则选取下一个城市
            Pcum=cumsum(P);
            Select=find(Pcum>=rand);
            to_visit=J(Select(1));
            Tabu(i,j)=to_visit;
        end
    end
    if NC>=2
        Tabu(1,:)=R_best(NC-1,:);
    end
    %记录本次迭代最佳路线
    L=zeros(m,1);
    for i=1:m
        R=Tabu(i,:);
        L(i)=CalDist(dislist,R);
    end
    L_best(NC)=min(L);
    pos=find(L==L_best(NC));
    R_best(NC,:)=Tabu(pos(1),:);
    L_ave(NC)=mean(L);
    drawTSP(Clist,R_best(NC,:),L_best(NC),NC,0);
    NC=NC+1;
    %更新信息素
    Delta_Tau=zeros(CityNum,CityNum);
    for i=1:m
        for j=1:(CityNum-1)
            Delta_Tau(Tabu(i,j),Tabu(i,j+1))=Delta_Tau(Tabu(i,j),Tabu(i,j+1))+Q/L(i);
        end
        Delta_Tau(Tabu(i,CityNum),Tabu(i,1))=Delta_Tau(Tabu(i,CityNum),Tabu(i,1))+Q/L(i);
    end
    Tau=(1-Rho).*Tau+Delta_Tau;
    Tabu=zeros(m,CityNum); %禁忌表清零
    %pause;
end

%输出结果
Pos=find(L_best==min(L_best));
Shortest_Route=R_best(Pos(1),:);
Shortest_Length=L_best(Pos(1));
figure(2);
plot([L_best L_ave]);
legend('最短距离','平均距离');