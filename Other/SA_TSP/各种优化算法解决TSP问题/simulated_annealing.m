function sa
clear
CityNum=30;
[dislist,Clist]=tsp(CityNum);
%t0,tf is the initial and finil temperature;alpha is controling temperature coeffient
tf=0.01;
alpha=0.80;
L=100*CityNum; %the length of Markov chain
for i=1:100
    route=randperm(CityNum);
    fval0(i)=CalDist(dislist,route);
end
t0=-(max(fval0)-min(fval0))/log(0.9)
fval=fval0(100);
route_best=route;
fval_best=fval;
t=t0;
ii=0;
while t>tf
    for i=1:L
        [fval_after,route_after]=exchange(route,dislist);
        if fval_after<fval
            route=route_after;
            fval=fval_after;
        elseif exp((fval-fval_after)/t)>rand
            route=route_after;
            fval=fval_after;
        end
    end
    ii=ii+1;
    drawTSP(Clist,route,fval,ii,0);
    if fval<fval_best
        route_best=route;
        fval_best=fval;
    end
    t=alpha*t;
    fval_sequence(ii)=fval;
end
drawTSP(Clist,route_best,fval_best,ii,1);
figure(2);
plot(1:ii,fval_sequence);%plot the convergence figure
title('ËÑË÷¹ý³Ì');
end

%----------------------------------------------------------------
function [fval_after,route_after]=exchange(route,d)
%changing traveling route by inversing the sequence between two selected 2 locations 
n=length(d);
location1=ceil(n*rand);
location2=location1;
while location2==location1
    location2=ceil(n*rand);%the location of two exchanged number
end
loc1=min(location1,location2);loc2=max(location1,location2);
middle_route=fliplr(route(loc1:loc2));%the part route which has been exchanged
route_after=[route(1:loc1-1) middle_route route(loc2+1:n)];%the after traveling route
fval_after=CalDist(d,route_after);
end
%---------------------------------------------------------------- 