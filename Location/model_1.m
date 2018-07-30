function [L_1,y,x] = model_1(ni,nj,p,c,d,C1,C2,D1,D2,K,num_k,a1,a2,a3,num_obj)
%Multistage Robust Location Problem - stage 1

% Parameters
small_num = 0.001;

%% Define variables x,y,w,u,v,L1,L2,L3,M,N
x = binvar(ni,nj,'full');y = binvar(nj,1);
for n = 1:num_k
    W{n} = binvar(ni,nj,'full');
    U{n} = binvar(nj,1);
    V{n} = binvar(ni,nj,'full');
end
L1 = sdpvar(1);L2 = sdpvar(num_k,1);L3 = sdpvar(num_k,1);M = sdpvar(1);N = sdpvar(1);

%% Define constraints
constraints=[];
% stage 1
%(1)xij<=yj
for i = 1:ni
  for j = 1:nj
    constraints=[constraints,x(i,j) <= y(j)];
  end
end

%(2)sum of xij = 1
for i = 1:ni
  constraints=[constraints,sum(x(i,:)) == 1];
end

%(3)sum y < p
constraints=[constraints,sum(y) <= p];

%(4)L1 >= cdx
cdx = 0;
for i = 1:ni
  for j= 1:nj
    cdx = cdx+c(i,j)*d(i)*x(i,j);
  end
  constraints=[constraints,L1 >= cdx];
  cdx=0;
end

% %(5)sum yj*kj <= q
% sum_yj_kj = 0;
% for i = 1:num_k
%    for j = 1:nj
%        sum_yj_kj = sum_yj_kj + y(j)*K{i}(j);
%    end
%    constraints=[constraints,sum_yj_kj <= q];
%    sum_yj_kj = 0;
% end

% stage_2
for n = 1:num_k
    %(6)wij <= yj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W{n}(i,j) <= y(j)]; 
       end
    end

    %(7)wij <= 1-kj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W{n}(i,j) <= 1-K{n}(j)]; 
       end
    end
    
    %(8)sum w = 1
    for i = 1:ni
       constraints=[constraints,sum(W{n}(i,:)) == 1];
    end
    
    %(9)L2 >= cdw
    cdw = 0;
    for i = 1:ni
        for j = 1:nj
            cdw = cdw+C1{n}(i,j)*D1{n}(i)*W{n}(i,j);
        end
        constraints=[constraints,L2(n) >= cdw];
        cdw=0;
    end
    %(18)M >= L2
    constraints=[constraints,M >= L2(n)];
end

%stage 3
for n =1:num_k
    %(10)vij<=yj+uj
    for i = 1:ni
       for  j = 1:nj
          constraints=[constraints,V{n}(i,j) <= y(j)+U{n}(j)];
       end
    end
    
    % (11)vij <=1-kj %!!未满足约束?
    for i = 1:ni
       for  j = 1:nj
          constraints=[constraints,V{n}(i,j) <= 1-K{n}(j)];
       end
    end
    
    %(12)sum vij = 1
    for i = 1:ni
        constraints=[constraints,sum(V{n}(i,:)) == 1];
    end
    
    %(13)uj+yj <= 1 (14)uj+kj <= 1
    for j = 1:nj
       constraints=[constraints,U{n}(j)+y(j) <= 1];
       constraints=[constraints,U{n}(j)+K{n}(j) <= 1]; 
    end
    
    %(15)sum uj + sum yj - sum kj*yj <= p
    sum_ky = 0;
    for j = 1:nj
        sum_ky = sum_ky+K{n}(j)*y(j);
    end
    constraints=[constraints,sum(U{n})+sum(y)-sum_ky <= p];
    
    %(16)L3 >= cdv
    cdv = 0;
    for i = 1:ni
        for j = 1:nj
            cdv = cdv+C2{n}(i,j)*D2{n}(i)*V{n}(i,j);
        end
        constraints=[constraints,L3(n) >= cdv];
        cdv=0;
    end
    
    %(19)N >= L3
    constraints=[constraints,N >= L3(n)];
end


%Objective function
sum_L = 0;
for n = 1:num_k
    sum_L = sum_L+L2(n)+L3(n);
end
if num_obj == 1
    %objective = a1*L1+a2*M+a3*N+small_num*sum_L;
    objective = a1*L1+a2*M+a3*N+small_num*sum_L+small_num*sum(y);% sum(y):防止出现没有被使用的设施点
elseif num_obj == 2
    %objective = L1;
    objective = L1+small_num*sum(y);
end

%设定
options = sdpsettings('solver','mosek','verbose',0);

sol = optimize(constraints,objective,options);

if sol.problem == 0
 % Extract and display value
 % solution_y = value(y)
 % solution_x = value(x)
 % solution_Obj = value(objective)
 L_1 = floor(value(L1));
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];

end