%draw legend
a = randi(100,1,2);
plot(a(1),a(2),'s','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',7)
hold on
b = randi(100,1,2);
plot(b(1),b(2),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)
c = randi(100,1,2);
plot(c(1),c(2),'o','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',7)
d = randi(100,1,2);
plot(d(1),d(2),'x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7) 
e = randi(100,1,2);
plot(e(1),e(2),'p','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',7)

plot([a(1),b(1)],[a(2),b(2)],'k:','LineWidth',1)
plot([c(1),d(1)],[c(2),d(2)],'g--','LineWidth',1)
legend('�����','��ѡ����ʩ��','δѡ����ʩ��','�����ʩ��','�½���ʩ��','�����Ȩ����','������ʩ����')
