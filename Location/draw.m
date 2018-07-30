%function [ ] = draw( xy_demand,xy_facility,y,x,w,u,v,K,n )
%DRAW 设施选址

clf
%%   画出三张图
%% （1）stage_1
subplot(2,3,1);
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y1(j)-1) <= 0.0000001
    plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
    else
    plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)  
    end
end
for i = 1:ni
   for j = 1:nj
       if x1(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'g--','LineWidth',1)
       end
   end
end
hold off
title('灾前规划');set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');

%% （2）stage_2 新建设施前
subplot(2,3,2)
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y1(j)-1) <= 0.0000001
        if K{n}(j) ==1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        end
    else
        if K{n}(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)  
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)
        end
    end
end
for i = 1:ni
   for j = 1:nj
       if w1(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'k:','LineWidth',1)
       end
   end
end
hold off
title('灾后反应');set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');

%% （3）stage_2 新建设施后
subplot(2,3,3);
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y1(j)-1) <= 0.0000001
        if K{n}(j) ==1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        end
    else
        if K{n}(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)  
        else
            if u1(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'p','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)
            else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)
            end
        end
        
    end
end
for i = 1:ni
   for j = 1:nj
       if v1(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'g--','LineWidth',1)
       end
   end
end
hold off
title('设施重建');set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');

%% 传统P-center
%%   画出三张图
%% （1）stage_1
subplot(2,3,4);
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y2(j)-1) <= 0.0000001
    plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
    else
    plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)  
    end
end
for i = 1:ni
   for j = 1:nj
       if x2(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'g--','LineWidth',1)
       end
   end
end
hold off
%title('stage 1');
set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');

%% （2）stage_2 新建设施前
subplot(2,3,5)
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y2(j)-1) <= 0.0000001
        if K{n}(j) ==1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        end
    else
        if K{n}(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)  
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)
        end
    end
end
for i = 1:ni
   for j = 1:nj
       if w2(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'k:','LineWidth',1)
       end
   end
end
hold off
set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');

%% （3）stage_2 新建设施后
subplot(2,3,6);
plot(xy_demand(1,:),xy_demand(2,:),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7) %需求点
hold on
for j = 1:nj
    if abs(y2(j)-1) <= 0.0000001
        if K{n}(j) ==1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
        end
    else
        if K{n}(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)  
        else
            if u2(j) == 1
            plot(xy_facility(1,j),xy_facility(2,j),'p','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)
            else
            plot(xy_facility(1,j),xy_facility(2,j),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)
            end
        end
        
    end
end
for i = 1:ni
   for j = 1:nj
       if v2(i,j) == 1
           plot([xy_demand(1,i),xy_facility(1,j)],[xy_demand(2,i),xy_facility(2,j)],'g--','LineWidth',1)
       end
   end
end
%hold off;


%title('stage 2');
set(gca,'xtick',[],'ytick',[],'yticklabel','','xticklabel','');
set(gcf,'position',[1921 181 1440 815]);
annotation(figure(1),'textbox',...
    [0.05021875 0.707692307692308 0.064625 0.081118881118881],...
    'String',{'Robust','P-center'},...
    'FitBoxToText','off','linestyle','none');
annotation(figure(1),'textbox',...
    [0.0470937500000001 0.258741258741259 0.0622812500000001 0.0559440559440559],...
    'String',{'P-center'},...
    'FitBoxToText','off','linestyle','none');
%% 小图标识
annotation(figure(1),'textbox',...
    [0.207638888888889 0.540984177546844 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1a-1'},...
    'FontWeight','bold',...
    'EdgeColor','none');
annotation(figure(1),'textbox',...
    [0.489583333333334 0.540984177546844 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1a-2'},...
    'FontWeight','bold',...
    'EdgeColor','none');
annotation(figure(1),'textbox',...
    [0.772916666666667 0.540984177546844 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1a-3'},...
    'FontWeight','bold',...
    'EdgeColor','none');
annotation(figure(1),'textbox',...
    [0.209027777777778 0.0672999670205274 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1b-1'},...
    'FontWeight','bold',...
    'EdgeColor','none','FitBoxToText','on');
annotation(figure(1),'textbox',...
     [0.491666666666667 0.0672999670205274 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1b-2'},...
    'FontWeight','bold',...
    'EdgeColor','none','FitBoxToText','on');
annotation(figure(1),'textbox',...
    [0.772222222222223 0.0672999670205274 0.0510416677180265 0.0421052638480538],...
    'String',{'图 1b-3'},...
    'FontWeight','bold',...
    'EdgeColor','none','FitBoxToText','on');

%result
draw_result1 = num2str(result(iteration,1:7));
annotation(figure(1),'textbox',...
    [0.904472222222223 0.946012269938651 0.00108333333333266 0.0343558282208611],...
    'String',draw_result1,'FitBoxToText','off','linestyle','none');
draw_result2 = num2str(result(iteration,8:14));
annotation(figure(1),'textbox',...
    [0.944750000000001 0.946012269938652 0.00108333333333266 0.034355828220861],...
    'String',draw_result2,'FitBoxToText','off','linestyle','none');


%% 计算结果

% draw_L11 = num2str(L_11);draw_L11 = ['L1 = ',draw_L11];
% annotation(figure(1),'textbox',...
%    [0.203604166666667 0.526633596330022 0.115145833333333 0.0559440559440559],...
%     'String',draw_L11,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_L12 = num2str(L_12);draw_L12 = ['L2 = ',draw_L12];
% annotation(figure(1),'textbox',...
%     [0.485114583333333 0.525317806856337 0.12165625 0.055944055944056],...
%     'String',draw_L12,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_L13 = num2str(L_13);draw_L13 = ['L3 = ',draw_L13];
% annotation(figure(1),'textbox',...
%     [0.679385416666672 0.524714822675805 0.116968749999996 0.055944055944056],...
%     'String',draw_L13,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_c1 = num2str(cost1);draw_c1 = ['cost1 = ',draw_c1];
% annotation(figure(1),'textbox',...
%     [0.739281250000006 0.539547294120293 0.115625002591147 0.0421052638480538],...
%     'String',draw_c1,...
%     'FitBoxToText','on','linestyle','none');
% 
% draw_cr1 = num2str(cost_r1);draw_cr1 = ['cost-r1 = ',draw_cr1];
% annotation(figure(1),'textbox',...
%     [0.830253472222228 0.531652557058592 0.0899305575340986 0.0513157903834394],...
%     'String',draw_cr1,...
%     'FitBoxToText','on','LineStyle','none');
% 
% draw_L21 = num2str(L_21);draw_L21 = ['L1’= ',draw_L21];
% annotation(figure(1),'textbox',...
%     [0.204559027777778 0.0511919327304636 0.162281249999999 0.0559440559440559],...
%     'String',draw_L21,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_L22 = num2str(L_22);draw_L22 = ['L2’= ',draw_L22];
% annotation(figure(1),'textbox',...
%      [0.487197916666667 0.0520417110722831 0.138322916666667 0.0559440559440559],...
%     'String',draw_L22,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_L23 = num2str(L_23);draw_L23 = ['L3’= ',draw_L23];
% annotation(figure(1),'textbox',...
%     [0.676954861111117 0.0535938715724766 0.154468749999994 0.055944055944056],...
%     'String',draw_L23,...
%     'FitBoxToText','off','linestyle','none');
% 
% draw_cr2 = num2str(cost_r2);draw_cr2 = ['cost-r2 = ',draw_cr2];
% annotation(figure(1),'textbox',...
%     [0.838586805555561 0.05928413600596 0.0899305575340986 0.0513157903834393],...
%     'String',draw_cr2,...
%     'FitBoxToText','on','LineStyle','none');
% 
% draw_c2 = num2str(cost2);draw_c2 = ['cost2 = ',draw_c2];
% annotation(figure(1),'textbox',...
%     [0.750479166666674 0.068052998941788 0.115625002591146 0.0421052638480538],...
%     'String',draw_c2,...
%     'FitBoxToText','on','linestyle','none');










%end

