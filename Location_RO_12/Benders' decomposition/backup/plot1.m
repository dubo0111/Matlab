load experiment_25
%result_25, 6*6 groups, 

figure
%title('Comparision between three methods')
for n =1:6
    na = [1,3,5,2,4,6];
    xy = result_25(1:6,5:8);result_25(1:6,:)=[];
    x=xy(:,1);y1=xy(:,2);y2=xy(:,3);y3=xy(:,4);
    subplot(3,2,na(n));
    plot(x,y1,'k-^',...
        x,y2,'k--s',...
        x,y3,'k:o','linewidth',1)
    if n ==3 | n==6
      xlabel('Number of scenarios')
    end
    if n ==1
        ylabel({'\alpha_1 = 0.2';'Computation time (s)'})
    elseif n==2
        ylabel({'\alpha_1 = 0.5';'Computation time (s)'})
    elseif n==3
        ylabel({'\alpha_1 = 0.8';'Computation time (s)'})
    end
    set(gca,'xtick',[5,100,200],'ytick',0:50:200);
    if n == 1
        title('p = 6');
    elseif n == 4;
        title('p = 10');
    end
end
legend1 = legend('CCG','BDD','LIP','Location','northwest','Orientation','horizontal');
set(gcf,'Position', [436 71 1051 899])
set(legend1,...
    'Position',[0.365049159530606 0.0187245081829767 0.271804632529584 0.030589544468117],...
    'Orientation','horizontal');
% annotation(figure(1),'textbox',...
%     [0.130729166666667 0.970449452686655 0.774479166666667 0.0211345939933258],...
%     'String',{'Comparision of three methods, |I| = 25'},...
%     'HorizontalAlignment','center',...
%     'FontWeight','bold',...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% set(gcf,'NextPlot','add');
% axes;
% h = title('MyTitle');
% set(gca,'Visible','off');
% set(h,'Visible','on');