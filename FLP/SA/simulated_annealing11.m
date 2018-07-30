function simulated_annealing11
clear
Num=323;%%
dislist=xlsread('distance.xlsx');
fc=CalFC(0.8);%
position=xlsread('Position.xlsx');
indexfc=xlsread('Facility.xlsx');
%[dislist,Clist]=tsp(Num);%%
%t0,tf is the initial and finil temperature;alpha is controling temperature coeffient
tf=0.01;
alpha=0.95;
L=10;%*Num; %the length of Markov chain
%生成固定染色体序列
fixed=zeros(1,60);
for i=324:383
    fixed(1,i-323)=i;
end
for i=1:100
    route0=randperm(Num);%
    route=route0;
    for j=1:size(fixed,2)
        route(1,size(route0,2)+j)=fixed(j);
    end
        fval0(i)=CalF(dislist,route,fc);%%
end
% for i=1:100%固定位置序列
%     for j=1:size(fixed,2)
%     route(i,size(route0,2)+j)=fixed(j);
%     end
% end
%     fval0(i)=CalF(dislist,route,fc);%%

% t0=-(max(fval0)-min(fval0))/log(0.9);%
t0=4000;
fval=fval0(100);
route_best=route0;
fval_best=fval;
t=t0;
ii=0;
tic;
while t>tf
    for i=1:L
        [fval_after,route_after]=exchange(route0,dislist,fixed,fc);
        if fval_after<fval
            route0=route_after;
            fval=fval_after;
        elseif exp((fval-fval_after)/t)>rand
            route0=route_after;
            fval=fval_after;
        end
    end
    ii=ii+1;
    route2=route0;
    for j=1:size(fixed,2)
        route2(1,size(route0,2)+j)=fixed(j);
    end
    draw(route2,position,indexfc,ii,fval);%%
    if fval<fval_best
        route_best=route0;
        fval_best=fval;
    end
    t=alpha*t;
    fval_sequence(ii)=fval;
    draw2(fval_sequence,0);
end
% drawTSP(Clist,route_best,fval_best,ii,1);%%
% figure(2);%%
% plot(1:ii,fval_sequence);%plot the convergence figure%%
% title('搜索过程');%%
end

%----------------------------------------------------------------
function [fval_after,route_after]=exchange(route0,d,fixed,fc)
%changing traveling route by inversing the sequence between two selected 2 locations 
n=323;%
location1=ceil(n*rand);
location2=location1;
while location2==location1
    location2=ceil(n*rand);%the location of two exchanged number
end
loc1=min(location1,location2);loc2=max(location1,location2);
middle_route=fliplr(route0(loc1:loc2));%the part route which has been exchanged
route_after=[route0(1:loc1-1) middle_route route0(loc2+1:n)];%the after traveling route
route_after1=route_after;
for j=1:size(fixed,2)
    route_after1(1,size(route0,2)+j)=fixed(j);
end
fval_after=CalF(d,route_after1,fc);%
end
%---------------------------------------------------------------- 