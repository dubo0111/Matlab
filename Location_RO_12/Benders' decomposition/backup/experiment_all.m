clear
A=[];KK=[5,10,20,40,80,100];

%for city_i=1:2
city_i=1;
    if city_i == 1
        city=25;
    else
        city=49;
    end
    for p_i = 3:3
        if p_i==1
            p = 6;sum_kj = 5;
        elseif p_i==2
            p =10;sum_kj = 8;
        else
            p =15;sum_kj=13;
        end
        for a_i = 1:3
            if a_i==1
                a1=0.2;
            elseif a_i==2
                a1=0.5;
            else
                a1=0.8;
            end
            for k_i =1:6
                num_k=KK(k_i);
                a2 = 1-a1;
                data(a1,a2, num_k ,p, sum_kj, city)
                t0=tic;
                [iter0, obj0,gap0]=CCG_gurobi;%
                t0=toc(t0);
                t1=tic;
                [iter1, obj1,gap1]=BDD_gurobi;%
                t1=toc(t1);
                t2 = tic;
                [iter2, obj2,gap2] = LIP_gurobi1;%
                t2 = toc(t2);
                A=[A;city,p,a1,a2,num_k,t0,t1,t2,iter0,iter1,iter2];
                save('experiment_result.mat','A');
            end
        end
    end

                
                
                
                
                
                
                
                
                
                
                