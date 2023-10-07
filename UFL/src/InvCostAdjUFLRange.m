function [ AdjustmentCostTotalPer,DiffNumberPer,cfinal,ufinal,ffinal,vfinal,FVAL ] = InvCostAdjUFLRange(m,n,dataread)


format short g
err = 0.0001;

%% read data
c=dataread([1:m],:);
u=dataread([(m+1):2*m],:);
f=dataread(2*m+1,:)';
v=dataread(2*m+2,:)';
ObjUFL=dataread(2*m+3,1);

mn=0;
for i=1:m
    for j=1:n
        if c(i,j)<inf
            mn=mn+1;
        end
    end
end
data = zeros(mn,3);
mncount = 0;
for i=1:m
    for j=1:n
        if c(i,j)<inf
            mncount = mncount+1;
            data(mncount,1)=i;
            data(mncount,2)=j;
            data(mncount,3)=c(i,j);
        end
    end
end
r = data(:,3);

optimalv = v;
optimalu = zeros(mn,1);
mncount = 0;
for i=1:m
    for j=1:n
        if c(i,j)<inf
            mncount = mncount+1;
            if u(i,j)==1
                optimalu(mncount) = 1;
            end
        end
    end
end


%% initial solution x0 = [v0;u0]
v0 = optimalv;
u0 = optimalu;
    optimalvalueL = ObjUFL*0.95;
    optimalvalueH = ObjUFL*1.05;

%% LP of the CIOP
% decision variable {tau^f;eta^f;tau^r;eta^r;fbar;rbar;pi;rho;ep}
%                      m    m     mn    mn    m     mn  m  mn  mn
w = [10000*ones(2*m,1);ones(2*mn,1)];
fobj = [w;zeros(2*m+3*mn,1);0];
%f = zeros(4*m+5*mn,1);

A = [zeros(1,3*m+3*mn),-ones(1,m),zeros(1,2*mn),1];
B = 0;

Aeq1 = zeros(m,4*m+5*mn+1);
Beq1 = zeros(m,1);
for i=1:m
    Aeq1(i,2*m+2*mn+i)=-1;
    for j=1:mn
        if data(j,1)==i
            Aeq1(i,4*m+3*mn+j)=1;
        end
    end
end



Aeq2 = zeros(mn,4*m+5*mn+1);
Beq2 = zeros(mn,1);
for j=1:mn
    Aeq2(j,3*m+3*mn+data(j,2))=1;
    Aeq2(j,4*m+3*mn+j)=-1;
    Aeq2(j,4*m+4*mn+j)=1;
    Aeq2(j,3*m+2*mn+j)=-1;
end

Aeq3 = [zeros(1,2*m+2*mn),v0',u0',zeros(1,m+2*mn),-1];
Beq3 = 0;

Aeq4 = zeros(m,4*m+5*mn+1);
Beq4 = -f;
for i=1:m
    Aeq4(i,i)=1;
    Aeq4(i,m+i)=-1;
    Aeq4(i,2*m+2*mn+i)=-1;
end


Aeq5 = zeros(mn,4*m+5*mn+1);
Beq5 = -data(:,3);
for j=1:mn
    Aeq5(j,2*m+j)=1;
    Aeq5(j,2*m+mn+j)=-1;
    Aeq5(j,3*m+2*mn+j)=-1;
end


Aeq = [Aeq1;Aeq2;Aeq3;Aeq4;Aeq5];

Beq = [Beq1;Beq2;Beq3;Beq4;Beq5];
LB = [zeros(2*m+2*mn,1);-inf*ones(m+mn,1);zeros(m+2*mn,1);optimalvalueL];
UB = [inf*ones(4*m+5*mn,1);optimalvalueH];

% decision variable {tau^f;eta^f;tau^r;eta^r;fbar;rbar;pi;rho;ep}
%                      m    m     mn    mn    m     mn  m  mn  mn


[X,FVAL] = linprog(fobj,A,B,Aeq,Beq,LB,UB);
format short
tauf = X((1):(m));
etaf = X((m+1):(2*m));
taur = X((2*m+1):(2*m+mn));
etar = X((2*m+mn+1):(2*m+2*mn));
fbar = X((2*m+2*mn+1):(3*m+2*mn));
rbar = X((3*m+2*mn+1):(3*m+3*mn));
pi = X((3*m+3*mn+1):(4*m+3*mn));
rho = X((4*m+3*mn+1):(4*m+4*mn));
ep = X((4*m+4*mn+1):(4*m+5*mn));


%corectness(m,n,data,fbar,rbar,ObjUFL,optimalv,optimalu);
fdiff = abs(fbar-f);
rdiff = abs(rbar-r);
fdiddper = fdiff./f;
rdiddper = rdiff./r;
diffper = [fdiddper;rdiddper];
diffper(diffper<err)=[];
DiifNumber = length(diffper);
DiffValuePerAvg = 100*sum(diffper)/length(diffper);



DiffNumberPer = 100*DiifNumber/(length(r));
AdjustmentCostOptPer = 100*FVAL/ObjUFL;
AdjustmentCostTotalPer = 100*FVAL/(sum(r));
%dlmwrite('result50-50.txt', [kk,m,n,DiffNumberPer,AdjustmentCostOptPer,AdjustmentCostTotalPer,t,FVAL,ObjUFL], 'precision', '%.3f', 'newline', 'pc','-append');


ffinal=fbar;
cfinal=zeros(m,n);
for i=1:m
    for j=1:n
        cfinal(i,j)=rbar(n*(i-1)+j);
    end
end
vfinaldiff=ffinal-fbar;
ufinaldiff=cfinal-c;
vfinal=zeros(m,1);
ufinal=zeros(m,n);
for i=1:m
    if abs(vfinaldiff(i))>err
        vfinal(i)=1;
    end
end
for i=1:m
    for j=1:n
        if abs(ufinaldiff(i,j))>err
            ufinal(i,j)=1;
        end
    end
end

end
