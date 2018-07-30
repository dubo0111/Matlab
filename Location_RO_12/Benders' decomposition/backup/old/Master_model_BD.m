function [ solution_y, solution_x, solution_Obj, Obj_L1,Obj_L2,time] = Master_model_BD( ni, nj,  r, kr, K, c, d, C1, D1, p, a1, a2, f, g, h)
%MASTER_MODEL for column and constraint algotithm
%   

%% Definition of parameters
%input_args: ||ni:demand node||nj:potential facility node||num_k:number of scenarios 
    %||r:iteration of algorithm;kr(r) identified scenario marix
    %sub-problem||c,d,C1,D1||
%output_args:


%% Define variables x,y,w,L1,L2,eta
x = binvar(ni,nj,'full'); % allocation
y = binvar(nj,1); % open facility
% for n = 1:r
%     W{n} = sdpvar(ni,nj,'full'); % re-allocation
% end
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

%% cutting plane
%kr
if isempty(kr) == 0
    for n = 1:r   % n-th loop of algorithm
        sum_yf = 0;sum_kg = 0;sum_h = 0;
        for i = 1:ni
           for j = 1:nj
              sum_yf = sum_yf +  y(j)*f{n}(i,j);
              sum_kg = sum_kg + (1-K{kr(n)}(j))*g{n}(i,j);
           end
           sum_h = sum_h + h{n}(i);
        end
        constraints =[constraints,eta >= (sum_yf + sum_kg + sum_h)];
    end
else
    eta = 0;
end

%% Objective function
objective = a1*L1+a2*eta;

%% Options

options = sdpsettings('solver','cplex','verbose',0);
t1 = tic;
sol = optimize(constraints,objective,options);
time = toc(t1);
if sol.problem == 0
 % Extract and display value
 solution_y = value(y);
 solution_x = value(x);
 solution_Obj = value(a1*L1+a2*eta);
 Obj_L1 = value (L1);
 Obj_L2 = value(eta);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end











end
