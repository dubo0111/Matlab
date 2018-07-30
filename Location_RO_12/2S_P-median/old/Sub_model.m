function [Obj] = Sub_model (y, ni, nj, nk, K, C1, D1 )
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
% for k = 1:nk
    for i = 1:ni
        for j = 1:nj
            constraints = [constraints,C1{nk}(i,j)*D1{nk}(i)*e(i)+f(i,j)+g(i,j)+h(i) <= 0];
        end
    end
% end
% yf ; (1-kj)g_ij ; hi
%for k = 1:num_k
%     sum_yf = 0;sum_kg = 0;sum_h = 0;
%     for i = 1:ni
%        for j = 1:nj
%           sum_yf = sum_yf +  y(j)*f(i,j);
%           sum_kg = sum_kg + (1-K{k}(j))*g(i,j);
%        end
%        sum_h = sum_h + h(i);
%     end
%     constraints = [constraints,Q_k >= sum_yf + sum_kg +sum_h];
%end
%e_i=-1
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

sol = optimize(constraints,objective,options);

if sol.problem == 0
 % Extract and display value
 Obj = value(sum_yf + sum_kg + sum_h);
 % identify k:
%  Qk = zeros (1,nk);
%  for n = 1:nk
%     sum_yf = 0;sum_kg = 0;sum_h = 0;
%     for i = 1:ni
%        for j = 1:nj
%           sum_yf = sum_yf +  y(i)*f(i,j);
%           sum_kg = sum_kg + (1-K{n}(j))*g(i,j);
%        end
%        sum_h = sum_h + h(i);
%     end
%     Qk (n) =value( sum_yf + sum_kg +sum_h);end
%  [~,kr] = max(Qk);
 
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end















end