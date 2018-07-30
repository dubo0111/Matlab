 function [UB, time] = CC2( )
%CC Summary of this function goes here
%   Detailed explanation goes here
load test1
%% initial parameters
LB = -inf; %initial lower bound
UB = inf;  %initial upper bound
iteration = 0; %
UB_LB = 0; e_now = 1e-5; % Stopping Criterion
kr = []; % identified scenario in each iteration
time = 0;
%% Master model
% Define variables x,y,w,L1,L2,eta
x = binvar(ni,nj,'full'); % allocation
y = binvar(nj,1); % open facility
%W ={}; L2={};
for i = 1: num_k
        W{i} = binvar(ni,nj,'full'); 
        L2{i} = sdpvar(1);
end
% Auxiliary variable:
L1 = sdpvar(1);eta = sdpvar(1);

% Define constraints
constraints_master=[];
% stage 1
%(1)xij<=yj
for i = 1:ni
  for j = 1:nj
    constraints_master=[constraints_master,x(i,j) <= y(j)];
  end
end

%(2)sum of xij = 1
for i = 1:ni
  constraints_master=[constraints_master,sum(x(i,:)) == 1];
end

%(3)sum y < p
constraints_master=[constraints_master,sum(y) <= p];

%(4)L1 >= cdx
cdx = 0;
for i = 1:ni
  for j= 1:nj
    cdx = cdx+c(i,j)*d(i)*x(i,j);
  end
  constraints_master=[constraints_master,L1 >= cdx];
  cdx=0;
end
% x>=0
for i = 1:ni
    for j = 1:nj
        constraints_master = [constraints_master,x(i,j) >= 0];
    end
end
%eta = 0;
% Objective function
%objective_master = a1*L1+0*eta;


% %% Sub model
% % Define Varibles
% for n = 1:num_k
%     e{n} = sdpvar(ni,1); f{n} = sdpvar(ni,nj,'full');g{n} = sdpvar(ni,nj,'full');h{n} = sdpvar(ni,1);
% end
% % Auxiliary variable:
% %Q_k = sdpvar(1); 
% % Define constraints
% constraints_sub=[];
% for n = 1:num_k
%     %
%     for i = 1:ni
%         for j = 1:nj
%             constraints_sub = [constraints_sub,C1{n}(i,j)*D1{n}(i)*e{n}(i)+f{n}(i,j)+g{n}(i,j)+h{n}(i) <= 0];
%         end
%     end
%     %
%     ei = 0;
%     for i = 1:ni
%         ei = ei + e{n}(i);
%     end
%     constraints_sub = [constraints_sub, -ei == 1];
%     % e,f,g <=0
%     for i = 1: ni
%         for j = 1:nj
%             constraints_sub = [constraints_sub , f{n}(i,j) <= 0 , g{n}(i,j) <= 0];
%         end
%         constraints_sub = [constraints_sub , e{n}(i) <= 0];
%     end   
% end
%[num_cons_sub,~]=size(constraints_sub);
% Objective function
% objective_sub = -Q_k;

% Options
options = sdpsettings('solver','gurobi','verbose',0);
options1 = sdpsettings('solver','gurobi','verbose',2);

%% 
while 1>0
%    update constraint_master
    if iteration~=0 % redefine re-allocation decision variable
        %(6)wij <= yj
        for i = 1:ni
           for j = 1:nj
              constraints_master=[constraints_master,W{iteration}(i,j) <= y(j)]; 
           end
        end

        %(7)wij <= 1-kj
        for i = 1:ni
           for j = 1:nj
              constraints_master=[constraints_master,W{iteration}(i,j) <= 1-K{kr(iteration)}(j)]; 
           end
        end

        %(8)sum w = 1
        for i = 1:ni
           constraints_master=[constraints_master,sum(W{iteration}(i,:)) == 1];
        end

        %(9)L2 >= cdw
        cdw = 0;
        for i = 1:ni
            for j = 1:nj
                cdw = cdw+C1{kr(iteration)}(i,j)*D1{kr(iteration)}(i)*W{iteration}(i,j);
            end
            constraints_master=[constraints_master,L2{iteration} >= cdw];
            cdw = 0;
        end
        % eta >= L2
        constraints_master = [constraints_master,eta >= L2{iteration}];
        % w>=0
        for i = 1:ni
            for j = 1:nj
                constraints_master = [constraints_master,W{iteration}(i,j) >= 0];
            end
        end
                objective_master = a1*L1+a2*eta;
    else
        objective_master = a1*L1;
    end
   %  solve MP
  t1 = tic;
  sol = optimize(constraints_master,objective_master,options);
  Time_MP = toc(t1)
  time = time+t1;
    if sol.problem == 0
         solution_y = value(y);
         solution_y = round(solution_y);
         if iteration == 0
             Obj_Master = value(a1*L1);
         else
             Obj_Master = value(a1*L1+a2*eta);
         end
         Obj_L1 = value (L1);
         %clear apause
    else
         display('Something went wrong!');
         sol.info
         yalmiperror(sol.problem)
    end
    if LB < Obj_Master
        LB = Obj_Master;
    end
    % update objective_sub(for new y)
%     obj_sp1 = cell(1,num_k); % save Objective of SP
%     for n = 1:num_k
%         sum_yf = 0;sum_kg = 0;sum_h = 0;
%         for i = 1:ni
%            for j = 1:nj
%               sum_yf = sum_yf +  solution_y(j)*f{n}(i,j);
%               sum_kg = sum_kg + (1-K{n}(j))*g{n}(i,j);
%            end
%            sum_h = sum_h + h{n}(i);
%         end
%         obj_sp1{n} = sum_yf + sum_kg + sum_h;
%     end  
%     objective_sub = 0;
%     for n = 1:num_k
%         objective_sub = objective_sub+obj_sp1{n};
%     end  
%     objective_sub = -objective_sub;
%     % solve SP
%     t2 = tic;
%     sol = optimize(constraints_sub,objective_sub,options1);
%     Time_SP = toc(t2)
%     time = time + t2;
%     if sol.problem == 0
         % update kr
%          obj_sp2=zeros(1,num_k);
%          for n = 1:num_k
%              obj_sp2(n) = value(obj_sp1{n});
%          end
% %          obj_sp2
%          [Obj_sub,kr_new] = max(obj_sp2);
%     else
%          display('Something went wrong!');
%          sol.info
%          yalmiperror(sol.problem)
%     end    
    if UB > (a1*Obj_L1 + a2*Obj_sub)
       UB = a1*Obj_L1 + a2*Obj_sub;
    end
    UB_LB = (UB - LB) / LB
    if abs(UB_LB) <= e_now
        UB
        break
    else
        iteration = iteration + 1
        kr = [kr,kr_new] %identified scenario
    end    


end

end
