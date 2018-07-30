function [L_1,X,Y] = pcenter_L1(ni,nj,p,c,d,C1,D1,K,num_k,a1,a2)
%Multistage Robust Location Problem - stage 1

%small_num = 1e-5;

%% Define variables x,y,w,u,v,L1,L2,L3,M,N
x = binvar(ni,nj,'full');y = binvar(nj,1);
% for n = 1:num_k
%     W{n} = binvar(ni,nj,'full');
% end
L1 = sdpvar(1);
%L2 = sdpvar(num_k,1);M = sdpvar(1);

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


% % stage_2
% for n = 1:num_k
%     %(6)wij <= yj
%     for i = 1:ni
%        for j = 1:nj
%           constraints=[constraints,W{n}(i,j) <= y(j)]; 
%        end
%     end
% 
%     %(7)wij <= 1-kj
%     for i = 1:ni
%        for j = 1:nj
%           constraints=[constraints,W{n}(i,j) <= 1-K{n}(j)]; 
%        end
%     end
%     
%     %(8)sum w = 1
%     for i = 1:ni
%        constraints=[constraints,sum(W{n}(i,:)) == 1];
%     end
%     
%     %(9)L2 >= cdw
%     cdw = 0;
%     for i = 1:ni
%         for j = 1:nj
%             cdw = cdw+C1{n}(i,j)*D1{n}(i)*W{n}(i,j);
%         end
%         constraints=[constraints,L2(n) >= cdw];
%         cdw=0;
%     end
%     %(18)M >= L2
%     constraints=[constraints,M >= L2(n)];
% end



%% Objective function
    objective = L1;
%% …Ë∂®
options = sdpsettings('solver','cplex','verbose',0);
tic
sol = optimize(constraints,objective,options);
toc
if sol.problem == 0
 % Extract and display value
 Y = value(y);
 X = value(x);
 L_1 = value(L1);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];




end

