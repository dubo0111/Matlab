load test
% Master model
% Define variables x,y,w,L1,L2,eta
x = binvar(ni,nj,'full'); % allocation
y = binvar(nj,1); % open facility

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
eta = 0;
% Objective function
objective_master = a1*L1+a2*eta;
options = sdpsettings('solver','cplex','verbose',0);

sol = optimize(constraints_master,objective_master,options);
if sol.problem == 0
     solution_y = value(y)
     Obj_Master = value(a1*L1+a2*eta)
     Obj_L1 = value (L1)
else
     display('Something went wrong!');
     sol.info
     yalmiperror(sol.problem)
end