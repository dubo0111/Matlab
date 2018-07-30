 function [ solution_y, solution_x, solution_Obj, Obj_L1, time] = Master_model( ni, nj,  r, kr, K, c, d, C1, D1, p, a1, a2)
%MASTER_MODEL for column and constraint algotithm
%   

%% Definition of parameters
%input_args: ||ni:demand node||nj:potential facility node||num_k:number of scenarios 
    %||r:iteration of algorithm;kr(r) identified scenario marix
    %sub-problem||c,d,C1,D1||
%output_args:

%t1 = tic;
%% Define variables x,y,w,L1,L2,eta
x = binvar(ni,nj,'full'); % allocation
y = binvar(nj,1); % open facility
for n = 1:r
    W{n} = sdpvar(ni,nj,'full'); % re-allocation
end
% Auxiliary variable:
L1 = sdpvar(1);L2 = sdpvar(r,1);eta = sdpvar(1);

%% Assign a scenario for initial master model
% if r == 1
%     kr (r) = 1;    
% end

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
% x>=0
for i = 1:ni
    for j = 1:nj
        constraints = [constraints,x(i,j) >= 0];
    end
end
%t1 = toc(t1)
%t2 = tic;
% stage_2 
for n = 1:r % n-th loop of algorithm
    %(6)wij <= yj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W{n}(i,j) <= y(j)]; 
       end
    end

    %(7)wij <= 1-kj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W{n}(i,j) <= 1-K{kr(n)}(j)]; 
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
            cdw = cdw+C1{kr(n)}(i,j)*D1{kr(n)}(i)*W{n}(i,j);
        end
        constraints=[constraints,L2(n) >= cdw];
        cdw = 0;
    end
    % eta >= L2
    constraints = [constraints,eta >= L2(n)];
    % w>=0
    for i = 1:ni
        for j = 1:nj
            constraints = [constraints,W{n}(i,j) >= 0];
        end
    end
end
%t2 = toc(t2)
%% Objective function
%tic
objective = a1*L1+a2*eta;
%% Options
options = sdpsettings('solver','cplex','verbose',0);
%toc
t1 = tic;
 sol = optimize(constraints,objective,options);
time = toc(t1);
if sol.problem == 0
 % Extract and display value
 solution_y = value(y);
 solution_x = value(x);
 solution_Obj = value(a1*L1+a2*eta);
 Obj_L1 = value (L1);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end











end
