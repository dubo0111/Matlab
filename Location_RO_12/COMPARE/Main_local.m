% experiment settings
ex_size=[10 20 30 40 50 60]; [~,Nex]=size(ex_size);
Nex2=5;% number of experiments for a size
k_size=[5 10 20 50 100 150 200]; [~,Nk] = size(k_size);
Np=3;
a1_all=[0.2 0.5 0.8];Na=3;

for i=1:Nex
    ni=ex_size(i);
    if i==1
        p_now=[2,3,5];
    else
        p_now=round([ni/5,ni/4,ni/3]);
    end
    for j=1:Nex2
        for k = 1:Np
            p=p_now(k);
            for l = 1:Nk
                num_k=k_size(l);
                for m=1:Na
                    a1=a1_all(m);
                    filename=['C:\Users\Du Bo\Desktop\data\',num2str(ni),'_',num2str(j),'_',num2str(num_k),'_',num2str(p),'_',num2str(a1),'.mat'];
                    load(filename);
                    %% 
                    t1=tic;
                    [iter1, obj1, gap1] = CCG_gurobi_1( a1,p,ni,nj,CD,CD1,K,num_k );
                    t1=toc(t1);
                    t2=tic;
                    [iter2, obj2, gap2] = BDD_gurobi( a1,p,ni,nj,CD,CD1,K,num_k );
                    t2=toc(t2);
                    t3=tic;
                    [iter3, obj3, gap3] = LIP_gurobi1( a1,p,ni,nj,CD,CD1,K,num_k);
                    t3=toc(t3);
                    
                    Result=[t1,iter1, obj1, gap1, t2, iter2, obj2, gap2, t3, iter3, obj3, gap3];
                       %%
                    savename=['C:\Users\Du Bo\Google ‘∆∂À”≤≈Ã\Matlab\Location_RO_12\COMPARE\Result\',num2str(ni),'_',num2str(j),'_',num2str(num_k),'_',num2str(p),'_',num2str(a1),'.mat'];
                    save(savename,'Result');
                end
            end
        end
    end
end