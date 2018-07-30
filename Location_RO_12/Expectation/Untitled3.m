clear
num_k = 10;p_k = zeros(1,num_k);
data_count=1; %save all data
for num_test = 4:6  
    if num_test <=3
        ni = 25; city = ni; 
        if num_test == 1
            aa = 0.2; 
        elseif num_test == 2
            aa = 0.5;
        elseif num_test == 3
            aa = 0.8;
        end
    else
        ni = 49; city = ni; 
        if num_test == 4
            aa = 0.2; 
        elseif num_test == 5
            aa = 0.5;
        elseif num_test == 6
            aa = 0.8;
        end        
    end
        for i = 1:num_k  
            %
            p_k(i) = 1/num_k; 
        end
    num_row  = 10;% 10 experiments
    Result = zeros(num_row+1,9);
    for nni = 1:num_row
        %DATA
        Main_Function( ni, city, aa, data_count)
        filename = ['C:\Users\n15075\Google Drive\Matlab\Location_RO_12\Expectation\data\test',num2str(data_count),'.mat'];
        data_count = data_count + 1;
        %% 2-stage RO
        load(filename)
        t1=tic;
        [Obj_L1,Obj_L2,~] = stage12(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2);
        L2_max = max(Obj_L2);L2_mean = mean(Obj_L2);
        t1=toc(t1);

        %% 2-stage SO
        load(filename)
        t2=tic;
        [L1_2exp,L2_2exp,~] = Tw0_Expectation (ni,nj,p,c,d,C1,D1,K,num_k,a1,a2,p_k);
        t2=toc(t2);
        L2_max_exp = max(L2_2exp);L2_mean_exp = mean(L2_2exp);
        t1
        t2
        Result (nni,:) = [Obj_L1, L2_max , L2_mean, L1_2exp, L2_max_exp, L2_mean_exp, (Obj_L1-L1_2exp)/Obj_L1,(L2_max-L2_max_exp)/L2_max, (L2_mean-L2_mean_exp)/L2_mean];
    end
    for nni = 1:num_row
        for j = 1:9
           Result(num_row+1,j) =  Result(num_row+1,j)+ Result(nni,j)/num_row;
        end
    end
    time_now = num2str(now);
    filename = ['R_',num2str(ni),'city_',num2str(a1),'_',num2str(a2),'_',num2str(num_row),'_',time_now,'.mat'];
    save(filename)
    Result
end




