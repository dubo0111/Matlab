function m=drawTSP(Clist,BSF,bsf,p,f)
CityNum=size(Clist,1);
for i=1:CityNum-1
    plot([Clist(BSF(i),1),Clist(BSF(i+1),1)],[Clist(BSF(i),2),Clist(BSF(i+1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
    hold on;
end
plot([Clist(BSF(CityNum),1),Clist(BSF(1),1)],[Clist(BSF(CityNum),2),Clist(BSF(1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
title([num2str(CityNum),'����TSP']);
if f==0
    text(5,5,['�� ',int2str(p),' ��','  ��̾���Ϊ ',num2str(bsf)]);
else
    text(5,5,['���������������̾��� ',num2str(bsf)]);
end
hold off;
pause(0.05); 