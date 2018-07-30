%% for 6 graphs
% experiment settings
ex_size=[10 20 30 40 50 60]; [~,Nex]=size(ex_size);
Nex2=5;% number of experiments for a size
k_size=[5 10 20 50 100 150 200]; [~,Nk] = size(k_size);
Np=3;
a1_all=[0.2 0.5 0.8];Na=3;

for i=1:6%
   ni=ex_size(i);
    if i==1
        p_now=[2,3,5];
    else
        p_now=round([ni/5,ni/4,ni/3]);
    end
     % Nex groups of data
    data=zeros(Nk,7); % save final data for file

    for l=1:Nk%
        num_k=k_size(l);
        data_k=zeros(Nex2*Na*Np,6); %save all Nex2*Na*Np (45) data
        index_data_k=1;
        for k=1:Np%
            p=p_now(k);
            for j=1:Nex2
                for m=1:Na
                    a1=a1_all(m);
                    savename=['C:\Users\Du Bo\Google ‘∆∂À”≤≈Ã\Matlab\Location_RO_12\COMPARE\Result\',num2str(ni),'_',num2str(j),'_',num2str(num_k),'_',num2str(p),'_',num2str(a1),'.mat'];
                    load(savename);
                    data_k(index_data_k,:)=[Result(1),Result(5),Result(9),0,0,0];
                    if data_k(index_data_k,1)<1000
                        data_k(index_data_k,4)=1;
                    else
                        data_k(index_data_k,1)=0;
                    end
                    if data_k(index_data_k,2)<1000
                        data_k(index_data_k,5)=1;
                    else
                        data_k(index_data_k,2)=0;
                    end
                    if data_k(index_data_k,3)<1000
                        data_k(index_data_k,6)=1;
                    else
                        data_k(index_data_k,3)=0;
                    end
                    index_data_k=index_data_k+1;
                end
            end
        end
        data(l,:)=[num_k,sum(data_k)];% mean value for k
        if data(l,5)~=0
            data(l,2)=data(l,2)/data(l,5);
        else
            data(l,2)=1000;
        end
        if data(l,6)~=0
            data(l,3)=data(l,3)/data(l,6);
        else
            data(l,3)=1000;
        end
        if data(l,7)~=0
            data(l,4)=data(l,4)/data(l,7);
        else
            data(l,4)=1000;
        end;
    end
    data(:,5:7)=[];
    %write data
    filename=[num2str(ni),'_0.dat'];
    fileID = fopen(filename,'w');
    fprintf(fileID,'%s %s %s %s\n','nk','t1','t2','t3');
    fprintf(fileID,'%f %f %f %f\n',data');
    fclose(fileID);
    data=zeros(Nk,7);
end