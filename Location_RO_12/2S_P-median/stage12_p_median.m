function [solution_x,solution_y,sum_cdx,sum_CDW,L1,L2] = stage12_p_median(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2)
%Multistage Robust Location Problem - stage 1

small_num = 1e-5;

%% Define variables x,y,w,u,v,L1,L2,L3,M,N
x = binvar(ni,nj,'full');y = binvar(nj,1);
for n = 1:num_k
    W{n} = binvar(ni,nj,'full');
end
%L1 = sdpvar(1);L2 = sdpvar(num_k,1);
M = sdpvar(1);

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
CDW = cell(1,num_k);
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
    %(9)M >= cdw
    cdw = 0;
    for i = 1:ni
        for j = 1:nj
            cdw = cdw+C1{n}(i,j)*D1{n}(i)*W{n}(i,j);
        end
    end
    CDW{n} = cdw;
    constraints=[constraints,M >= cdw];
end



%% Objective function
cdx = 0;
for i = 1:ni
  for j= 1:nj
    cdx = cdx+c(i,j)*d(i)*x(i,j);
  end
end
sum_cdw = 0;
for n = 1:num_k
    sum_cdw = sum_cdw+CDW{n};
end
    objective = a1*cdx+a2*M%+small_num*sum_cdw+small_num*sum(y);% sum(y):防止出现没有被使用的设施点

%% 设定
options = sdpsettings('solver','gurobi','verbose',1);
tic
sol = optimize(constraints,objective,options);
toc
if sol.problem == 0
 % Extract and display value
 solution_y = value(y);
 solution_x = value(x);
%  solution_Obj = value(a1*L1+a2*M);
 sum_cdx = value(cdx);
 sum_CDW = zeros(1,num_k);
 solution_w  = cell(1,num_k);
 for i = 1:num_k
     sum_CDW(i) = value(CDW{i});
     solution_w{i} = value(W{i});
 end
 L_cdx = zeros(1,ni);
 for i = 1:ni
     for j = 1:nj
         L_cdx(i) = L_cdx(i) + c(i,j)*d(i)* solution_x(i,j);
     end
 end
 L1 = max(L_cdx);
 
 L2 = zeros(1,num_k);L_cdw = zeros(1,ni);
 for n = 1:num_k
     for i = 1:ni
         for j = 1:nj
             L_cdw(i) = L_cdw(i) + C1{n}(i,j)*D1{n}(i)*solution_w{n}(i,j);
         end
     end
     L2(n) = max(L_cdw);
     L_cdw = zeros(1,ni);
 end
 
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];





end

