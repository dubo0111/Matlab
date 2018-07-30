function [f, g, h, Obj, time] = Sub_model_BD (y, ni, nj, nk, K, C1, D1 )
%SUB_MODEL for column and constraint algotithm
%   

%% Definition of parameters
% Input_args: y_*(y),ni,nj,num_k,K{},
% Output_args: 
%% Define Varibles
e = sdpvar(ni,1); f = sdpvar(ni,nj,'full');g = sdpvar(ni,nj,'full');h = sdpvar(ni,1);
% Auxiliary variable:
Q_k = sdpvar(1); 
%% Define constraints
constraints=[];
% 
    for i = 1:ni
        for j = 1:nj
            constraints = [constraints,C1{nk}(i,j)*D1{nk}(i)*e(i)+f(i,j)+g(i,j)+h(i) <= 0];
        end
    end
ei = 0;
for i = 1:ni
    ei = ei + e(i);
end
constraints = [constraints, -ei == 1];
% e,f,g <=0
for i = 1: ni
    for j = 1:nj
        constraints = [constraints , f(i,j) <= 0 , g(i,j) <= 0];
    end
    constraints = [constraints , e(i) <= 0];
end
        
%% Objective function
sum_yf = 0;sum_kg = 0;sum_h = 0;
for i = 1:ni
   for j = 1:nj
      sum_yf = sum_yf +  y(j)*f(i,j);
      sum_kg = sum_kg + (1-K{nk}(j))*g(i,j);
   end
   sum_h = sum_h + h(i);
end
objective = -(sum_yf + sum_kg + sum_h);

%% Options

options = sdpsettings('solver','cplex','verbose',0);
t1 = tic;
sol = optimize(constraints,objective,options);
time = toc(t1);
if sol.problem == 0
 % Extract and display value
 Obj = value(sum_yf + sum_kg + sum_h);
 f = value(f);g = value(g);h = value(h);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end



end