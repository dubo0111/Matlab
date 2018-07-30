load experiment_49_1
%result_25, 6*9 groups, 
% [a,b]=size(A);
% for i = 1:a
%     for j = 1:b
%         if A(i,j) == -inf
%            A(i,j) = inf;
%         end
%     end
% end% -inf to inf
result_49 = A;

figure
%title('Comparision between three methods')
for n =1:9
    %na = [1,3,5,2,4,6];
    xy = result_49(1:6,5:8);result_49(1:6,:)=[];
    x=xy(:,1);y1=xy(:,2);y2=xy(:,3);y3=xy(:,4);
    subplot(3,3,n);
    plot(x,y1,'k-^',...
        x,y2,'k--s',...
        x,y3,'k:o','linewidth',1)
    yy = ['\alpha_1 = ',num2str(A(n*6,3))];
    if n==1||n==4||n==7
        ylabel({yy;'Computation time (s)'});
    end
    if n==7||n==8||n==9
        xlabel('Number of scenarios')
    end
%     if n ==1
%         ylabel({'\alpha_1 = 0.2';'Computation time (s)'})
%     elseif n==2
%         ylabel({'\alpha_1 = 0.5';'Computation time (s)'})
%     elseif n==3
%         ylabel({'\alpha_1 = 0.8';'Computation time (s)'})
%     end
     set(gca,'xtick',[20,40,80,100],'ytick',0:500:1000,'ylim',[0,1000]);
     if n==1||n==2||n==3
         title(['p = ',num2str(A(n*6,2))]);
     end
end
legend1 = legend('CCG','BDD','LIP','Location','northwest','Orientation','horizontal');
set(gcf,'Position', [54 67 1593 911])
set(legend1,...
    'Position',[0.365049159530606 0.0187245081829767 0.271804632529584 0.030589544468117],...
    'Orientation','horizontal');
% annotation(figure(1),'textbox',...
%     [0.130729166666667 0.970449452686655 0.774479166666667 0.0211345939933258],...
%     'String',{'Comparision of three methods, |I|=49'},...
%     'HorizontalAlignment','center',...
%     'FontWeight','bold',...
%     'FitBoxToText','off',...
%     'EdgeColor','none');
% set(gcf,'NextPlot','add');
% axes;
% h = title('MyTitle');
% set(gca,'Visible','off');
% set(h,'Visible','on');