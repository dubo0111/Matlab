% experiment settings
ex_size=[10 20 30 40 50 60];%ex_size=[10 20 30 40 50 60];
[~,Nex]=size(ex_size);
Nex2=5;% number of experiments for a size
k_size=[5 10 20 50 100 150 200]; [~,Nk] = size(k_size);
Np=3;
a1_all=[0.2 0.5 0.8];Na=3;

table=zeros(Nex*Nk,13);
index_table=1;
for i=1:Nex%
   ni=ex_size(i);
    if i==1
        p_now=[2,3,5];
    else
        p_now=round([ni/5,ni/4,ni/3]);
    end
    for l=1:Nk%
        num_k=k_size(l);
        BD=zeros(Np*Na*Nex2,4);CCG=BD;LIP=BD; %save all data
        index_data_k=1;
        for k=1:Np%
            p=p_now(k);
            for j=1:Nex2
                for m=1:Na
                    a1=a1_all(m);
                    savename=['C:\Users\Du Bo\Google ÔÆ¶ËÓ²ÅÌ\Matlab\Location_RO_12\COMPARE\Result\',num2str(ni),'_',num2str(j),'_',num2str(num_k),'_',num2str(p),'_',num2str(a1),'.mat'];
                    load(savename);
                    CCG(index_data_k,:)=Result(1:4);BD(index_data_k,:)=Result(5:8);LIP(index_data_k,:)=Result(9:12);
                    index_data_k=index_data_k+1;
                end
            end
        end
        for nn=1:Np*Na*Nex2
            if BD(nn,1)>1000
                BD(nn,1:3)=0; 
            else
                BD(nn,3)=1;   
            end
            if BD(nn,4)<1e-8
                BD(nn,4)=0;            
            end
             if CCG(nn,1)>1000
                CCG(nn,1:3)=0; 
             else
                 CCG(nn,3)=1;
             end
             if CCG(nn,4)<1e-8
                CCG(nn,4)=0;            
            end
             if LIP(nn,1)>1000
                LIP(nn,1:3)=0;
             else
                 LIP(nn,3)=1;
             end
            if LIP(nn,4)<1e-8
                LIP(nn,4)=0;            
            end
        end
        %mean value (!!for solved and unsolved cases)
        casenum=Np*Na*Nex2;
        CCG_new=sum(CCG);CCG_new(1)=CCG_new(1)/CCG_new(3);CCG_new(2)=CCG_new(2)/CCG_new(3);
        if casenum~=CCG_new(3)
            CCG_new(4)=CCG_new(4)/(casenum-CCG_new(3));
        end
        BD_new=sum(BD);BD_new(1)=BD_new(1)/BD_new(3);BD_new(2)=BD_new(2)/BD_new(3);
        if casenum~=BD_new(3)
            BD_new(4)=BD_new(4)/(casenum-BD_new(3));
        end
        LIP_new=sum(LIP);
        if LIP_new(3)~=0
            LIP_new(1)=LIP_new(1)/LIP_new(3);
        end
        if casenum~=LIP_new(3)
            LIP_new(4)=LIP_new(4)/(casenum-LIP_new(3));
        end
        LIP_new(:,2)=[];
        table(index_table,:)=[ni,num_k,CCG_new,BD_new,LIP_new];
        index_table=index_table+1;
%         if ni==30 && num_k==150
%             aa=11;
%         end
    end
end
xlswrite('table.xls',table)





