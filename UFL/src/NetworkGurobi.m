function [ v1,u1,obj1,objboundUFL,timeUFL,result ] = NetworkGurobi(m,n,c,f)
% This function is to construct a network for the UFL problem.
% m is the number of facilities, n is the number of customers.



% c is the cost matrix
%c = randi([1,100],[m*n,1]);

% if m<=10
%     m2 = round(m/2);
% end
% if 11<m<=20
%     m2 = 5;
% end
% if 21<m<=30
%     m2 = 7;
% end
% if 31<m<=50
%     m2 = 8;
% end
% if 51<m<=80
%     m2 = 8;
% end
% if 81<m<=100
%     m2 = 10;
% end


% f is the facility cost vector
%f = randi([100,200],[m,1]);
mn = m*n;


objc = [f;c];

LHS = zeros(n+mn,m+mn);
RHS = zeros(n+mn,1);
for j=1:n
    for i=1:m
        LHS(j,m+(i-1)*n+j) = 1;
    end
    RHS(j,1) = 1;
end

for i=1:m
    for j=1:n
        LHS(n+(i-1)*n+j,i) = 1;
        LHS(n+(i-1)*n+j,m+(i-1)*n+j) = -1;
        RHS(n+(i-1)*n+j,1) = 0;
    end
end
clear model;
model.obj = objc;
model.A = sparse(LHS);
for i=1:n
    model.sense(i) = ['='];
end
for i=(n+1):(n+mn)
    model.sense(i) = ['>'];
end
model.rhs = RHS;
model.vtype = 'B';



clear params;
params.Presolve = 2;
params.TimeLimit = 3600*5;

result = gurobi(model, params);
objboundUFL = result.objbound;
timeUFL = ceil(result.runtime);
obj1 = result.objval;
vu = result.x;
v1 = vu((1):(m),1);
u = vu((m+1):(m+mn),1);
c1 = zeros(m,n);
u1 = zeros(m,n);
for i=1:m
    c1(i,:) = c(((i-1)*n+1):(i*n),1);
    u1(i,:) = u(((i-1)*n+1):(i*n),1);
end
end

