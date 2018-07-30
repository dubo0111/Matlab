%Normal P-center Model
%Parameters
ni = 4;%需求点数量
nj = 4;%可选设施点数量

p = 2;%设施限制

c = randi(100,ni,nj);
d = randi(100,ni,1);
% c =[167    69    85    75;
%    108   192   103   148;
%     86   194   174   160;
%    110   136    52   147;
%     64    59    56   118];
% d = [61;
%     69;
%     34;
%     77;
%     69];

%Define variables x,y,L
x = binvar(ni,nj,'full');
y = binvar(nj,1);
L = sdpvar(1);

%Define constraints
constraints=[];

%xij<=yj
for i = 1:ni
  for j = 1:nj
    constraints=[constraints,x(i,j)<=y(j)];
  end
end

%L>=cdx
cdx = 0;
for i = 1:ni
  for j= 1:nj
    cdx=cdx+c(i,j)*d(i)*x(i,j);
  end
  %or cdx = c(i,j)*d(i)*(sum(x(i,:))
  constraints=[constraints,L>=cdx];
  cdx=0;
end

%p
constraints=[constraints,sum(y)<=p];

%sum of xij=1
for i = 1:ni
  constraints=[constraints,sum(x(i,:))==1];
end


objective = L;


%设定
options = sdpsettings('solver','cplex','verbose',1);

sol = optimize(constraints,objective,options);


if sol.problem == 0
 % Extract and display value
 solution_y = value(y)
 solution_x = value(x)
 Value_L = value(L)
else
 display('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
clear



