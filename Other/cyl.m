function cyl
%F=203/384+1/2.*x(x>=0 & x<48/41)+2.*(144+x.*(-1468+2441.*x))/9.*(16-31.*x).^2.*(x>=48/41 & x<=2)
%axis off;
for x=0:0.001:48/41
    y=203/384+1/(2.*x);
    plot(x,y,'ro','linewidth',1);
    hold on
end

for x=48/41:0.001:2
    y=(2.*(144+x.*(-1468+2441.*x)))/(9.*(16-31.*x).^2);
    plot(x,y,'bo','linewidth',1);
end

set(gca,'xtick',0);
set(gca,'ytick',0);

%x1=0:0.01:48/41;

%y1=
%x2=48/41:0.01:2;
%y2=2.*(144+x2.*(-1468+2441.*x2))/9*(16-31.*x2).^2;
%x=[x1,x2];
%y=[y1,y2];
%plot(x1,y1);

end

