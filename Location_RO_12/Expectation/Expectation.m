function [L_1,L_2,solution_Obj] = Expectation (ni,nj,p,c,d,C1,D1,K,num_k,a1,a2,p_k)
%Multistage Robust Location Problem - stage 1

small_num = 1e-5;

%% Define variables x,y,w,u,v,L1,L2,L3,M,N
x = binvar(ni,nj,'full');y = binvar(nj,1);
for n = 1:num_k
    W{n} = binvar(ni,nj,'full');
end
%L1 = sdpvar(1);
L2 = sdpvar(num_k,1);%M = sdpvar(1);

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
% cdx = 0;
% for i = 1:ni
%   for j= 1:nj
%     cdx = cdx+c(i,j)*d(i)*x(i,j);
%   end
%   constraints=[constraints,L1 >= cdx];
%   cdx=0;
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
    %constraints=[constraints,M >= L2(n)];
end



%% Objective function
sum_L = 0;
for n = 1:num_k
    sum_L = sum_L+p_k(n)*L2(n);
end
    objective =sum_L;% sum(y):防止出现没有被使用的设施点

%% 设定
options = sdpsettings('solver','cplex','verbose',0);
tic
sol = optimize(constraints,objective,options);
toc
if sol.problem == 0
 % Extract and display value
%  solution_y = value(y);
%  solution_x = value(x);
 solution_Obj = value(objective);
 L_2 = max(value(L2));
 
cdx = zeros(1,ni); l1 = 0;
for i = 1:ni
  for j= 1:nj
    l1 = l1+c(i,j)*d(i)*x(i,j);
  end
  cdx(i) = l1; l1 = 0;
end
L_1 = max(value(cdx));

else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];
%转换x,y
% I=[];J=[];
% for i = 1:ni
%    if solution_y(i)==1
%        I=[I,i];
%    else
%        J=[J,i];
%    end
% end
% X = [I,J];




end

