load city_250
cost_all=city_250(:,2:3);cost_all=cell2mat(cost_all);
demand=city_250(:,4);demand=cell2mat(demand);
% experiment settings
ex_size=[10 20 30 40 50 60]; [~,Nex]=size(ex_size);
Nex2=5;% number of experiments for a size
k_size=[5 10 20 50 100 150 200]; [~,Nk] = size(k_size);
%p=round([ex_size/5,ex_size/4,ex_size/3]);
Np=3;
a1_all=[0.2 0.5 0.8];Na=3;

%% begin generating all experiments
for i=1:Nex
    ni=ex_size(i);
    if i==1
        p_now=[2,3,5];
    else
        p_now=round([ni/5,ni/4,ni/3]);
    end
    for j=1:Nex2
        rand = randi(250,1,ni);
        location=zeros(ni,2);d=zeros(1,ni);
        for n=1:ni
            location(n,:)=cost_all(rand(n),:); 
            d(n) = demand(rand(n));
        end
       c = distance(location');d=d';
        for k = 1:Np
            p=p_now(k);
            for l = 1:Nk
                num_k=k_size(l);
                sum_kj=p-1; %
                [ C1,~,D1,~ ] = scenario_cd( num_k,c,d); 
                [ K ] = scenario_k( sum_kj,num_k,ni );
                for m=1:Na
                    nj=ni;
                    CD=zeros(ni,nj);
                    CD1=cell(1,num_k);
                    for kk = 1:num_k
                        CD1{kk}=zeros(ni,nj);
                    end
                    %c*d;c1*d1
                    for ii = 1:ni
                        for jj = 1:nj
                            CD (ii,jj) = c(ii,jj)*d(ii);
                        end
                    end
                    for kk = 1:num_k
                        for ii = 1:ni
                            for jj = 1:nj
                                CD1{kk}(ii,jj) = C1{kk}(ii,jj)*D1{kk}(ii);
                                %CD1{k}=CD1{k}/(1e8);
                            end
                        end
                    end
                    a1=a1_all(m);
%                     if ni==60 
                        filename=['C:\matlab\DATA\',num2str(ni),'_',num2str(j),'_',num2str(num_k),'_',num2str(p),'_',num2str(a1),'.mat'];
                        save(filename,'ni','nj','j','num_k','p','a1','CD','CD1','K');
%                     end
                end
            end
        end
    end
end