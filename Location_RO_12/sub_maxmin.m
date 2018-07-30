function [solution_w, solution_Obj] = Sub_not_dual_model (y, ni, nj, nk, K, C1, D1 )
%SUB_MODEL for column and constraint algotithm
%   

%% Define variables 

W = binvar(ni,nj,'full');
L2 = sdpvar(1,1);

%% Define constraints
constraints=[];
% stage_2
    %(6)wij <= yj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W(i,j) <= y(j)]; 
       end
    end

    %(7)wij <= 1-kj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,W(i,j) <= 1-K{nk}(j)]; 
       end
    end
    
    %(8)sum w = 1
    for i = 1:ni
       constraints=[constraints,sum(W(i,:)) == 1];
    end
    
    %(9)L2 >= cdw
    cdw = 0;
    for i = 1:ni
        for j = 1:nj
            cdw = cdw+C1{nk}(i,j)*D1{nk}(i)*W(i,j);
        end
        constraints=[constraints,L2 >= cdw];
        cdw=0;
    end



%% Objective function
    objective = L2;


%% …Ë∂®
options = sdpsettings('solver','mosek','verbose',0);

sol = optimize(constraints,objective,options);

if sol.problem == 0
 % Extract and display value
 solution_w = value(W);
 solution_Obj = value(L2);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
constraints = [];



end