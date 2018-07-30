function [cost,cost_t,cost_b,cost_r,L_3,u,v] = model_2(K ,n, y , x , ck ,dk, pk, B, R, L_max)
%Multistage Robust Location Problem - stage 2

%% Parameters
%ni = 10;%需求点数量
%nj = 5;%可选设施点数量
[ni,nj] = size(ck);

%% Define variables u,v
v = binvar(ni,nj,'full');u = binvar(nj,1);

%% Define constraints
constraints=[];
%(1)vij<=yj+uj
for i = 1:ni
   for  j = 1:nj
      constraints=[constraints,v(i,j) <= y(j)+u(j)];
   end
end

% (2)vij <=1-kj
for i = 1:ni
   for  j = 1:nj
      constraints=[constraints,v(i,j)<=1-K{n}(j)];
   end
end

%(3)sum vij = 1
for i = 1:ni
    constraints=[constraints,sum(v(i,:))==1];
end

%(4)uj+yj <= 1 (5)uj+kj <= 1
for j = 1:nj
   constraints=[constraints,u(j)+y(j) <= 1];
   constraints=[constraints,u(j)+K{n}(j) <= 1]; 
end

%(6)sum uj + sum yj - sum kj*yj <= p
sum_ky = 0;
for j = 1:nj
    sum_ky = sum_ky+K{n}(j)*y(j);
end
constraints=[constraints,sum(u)+sum(y)-sum_ky <= pk];

%(7)cdv <= L_max
cdv = 0;L_save = [];
for i = 1:ni
    for j = 1:nj
        cdv = cdv+ck(i,j)*dk(i)*v(i,j);
    end
    constraints=[constraints,cdv <= L_max];
    L_save = [L_save,cdv];cdv=0;
end

%Objective function
sum_cdv=0;
for i =1:ni
    for j =1:nj
        sum_cdv = sum_cdv+ck(i,j)*dk(i)*v(i,j);
    end
end 
diff_xv = 0;
for i =1:ni
    for j =1:nj
        diff_xv = diff_xv + abs(x(i,j)-v(i,j));
    end
end 

objective = sum_cdv+B*sum(u)+R*diff_xv;

%设定
options = sdpsettings('solver','mosek','verbose',0);

sol = optimize(constraints,objective,options);

if sol.problem == 0
 % Extract and display value
 %solution_u = value(u)
 %solution_v = value(v)
 cost = floor(value(objective));%总成本
 L_3 = floor(max(value(L_save)));
 cost_t = floor(value(sum_cdv));%总运输成本
 cost_b = floor(B*sum(u));%设施修建成本
 cost_r = floor(value(R*diff_xv));%重新分配惩罚成本
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];

end