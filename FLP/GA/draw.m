function m=draw(x,Position,indexfc,gn,fmax)
    x11=[];y11=[];x21=[];y21=[];x31=[];y31=[];x41=[];y41=[];x51=[];y51=[];x61=[];y61=[];x71=[];y71=[];x81=[];y81=[];
%     x=xx;
%     生成固定染色体序列
% fixed=zeros(1,60);
% for i=324:383
%     fixed(1,i-323)=i;
% end
% for j=1:size(fixed,2)
%    x(1,size(xx,2)+j)=fixed(j);
% end
for i=1:size(x,2)
   %axis([0 30 -20 0]);
    if indexfc(i,1)==1
        x1=Position(x(i),2);
        y1=Position(x(i),1);
        x11=[x11,x1];
        y11=[y11,y1];
    elseif indexfc(i,1)==2
        x2=Position(x(i),2);
        y2=Position(x(i),1);
        x21=[x21,x2];
        y21=[y21,y2];
        elseif indexfc(i,1)==3
            x3=Position(x(i),2);
        y3=Position(x(i),1);
        x31=[x31,x3];
        y31=[y31,y3];
            elseif indexfc(i,1)==4
                x1=Position(x(i),2);
        y1=Position(x(i),1);
        x41=[x41,x1];
        y41=[y41,y1];
                elseif indexfc(i,1)==5
                    x1=Position(x(i),2);
        y1=Position(x(i),1);
        x51=[x51,x1];
        y51=[y51,y1];
                    elseif indexfc(i,1)==6
                        x1=Position(x(i),2);
        y1=Position(x(i),1);
        x61=[x61,x1];
        y61=[y61,y1];
                        elseif indexfc(i,1)==7
                            x1=Position(x(i),2);
        y1=Position(x(i),1);
        x71=[x71,x1];
        y71=[y71,y1];
        elseif indexfc(i,1)==8||indexfc(i,1)==9||indexfc(i,1)==10
                            x1=Position(x(i),2);
        y1=Position(x(i),1);
        x81=[x81,x1];
        y81=[y81,y1];
    end
end
subplot(2,1,1);
plot(x11,-y11,'s','MarkerFaceColor','b','MarkerSize',5);
hold on;
plot(x21,-y21,'s','MarkerFaceColor','r','MarkerSize',5);
plot(x31,-y31,'s','MarkerFaceColor','g','MarkerSize',5);
plot(x41,-y41,'s','MarkerFaceColor','c','MarkerSize',5);
plot(x51,-y51,'s','MarkerFaceColor','m','MarkerSize',5);
plot(x61,-y61,'s','MarkerFaceColor','y','MarkerSize',5);
plot(x71,-y71,'s','MarkerFaceColor','k','MarkerSize',5);
plot(x81,-y81,'o','MarkerFaceColor','w','MarkerSize',8);
grid;
title(['第 ',int2str(gn),' 步','  最优值为 ',num2str(fmax),'  已运行时间 ',num2str(fix(toc)),'秒']);
legend('促销区','拣货区','高架区','重货区','贵品区','恒温区','洗化区','固定的功能区',-1);
%text(-18,15,['第 ',int2str(gn),' 步','  最优值为 ',num2str(fmin)]);
hold off;

pause(0.005);



end
