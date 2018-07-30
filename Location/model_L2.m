function [ L_2,w1 ] = model_L2( yy,K,n,ck,dk,ni,nj )
% 

%% Define variables w,L2
w = binvar(ni,nj,'full');
L2 = sdpvar(1,1);
%% Define constraints
constraints = [];
    %(6)wij <= yj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,w(i,j)<=yy(j)]; 
       end
    end

    %(7)wij <= 1-kj
    for i = 1:ni
       for j = 1:nj
          constraints=[constraints,w(i,j)<=1-K{n}(j)]; 
       end
    end
    
    %(8)sum w = 1
    for i = 1:ni
       constraints=[constraints,sum(w(i,:))==1];
    end
    
    %(9)L2 >= cdw
    cdw = 0;
    for i = 1:ni
        for j = 1:nj
        cdw = cdw+ck(i,j)*dk(i)*w(i,j);
        end
        constraints=[constraints,L2>= cdw];
        cdw=0;
    end
    
%% 
objective = L2;
%% 
options = sdpsettings('solver','mosek','verbose',0);

sol = optimize(constraints,objective,options);


if sol.problem == 0
 % Extract and display value
 %solution_w = value(w);
 L_2 = floor(value(L2));
 w1 = value(w);
else
 display('Something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end

constraints = [];

end

