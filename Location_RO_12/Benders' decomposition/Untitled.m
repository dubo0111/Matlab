Obj_allsub = zeros(1,num_k);
for n = 1:num_k % solve every scenario
    for j = 1:nj %survived facility
        if y(j) == 1
            if K{n}(j) == 1
                %y(j) = 0;
                CD1{n}(:,j)=1e10;
            end
        else
            CD1{n}(:,j)=1e10;
        end
    end
    [cost,facility]=min(CD1{n},[],2); %closest faclity
    obj_allsub(n) = max(cost);
end
[obj_sub,kr_new] = max(obj_allsub)