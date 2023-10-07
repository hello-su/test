function [adjpernum,adjpervalue,finaladj,edgefinal,xinverse] = InvCostAdjWM(m,dataread)
%%
em = m*(m-1)/2;
edge=dataread([1:em],[1:3]);
w=dataread([1:em],3);
xvector=dataread([1:em],4);
optimalvalue=dataread(em+1,1);

%% step 1
%% tau  eta  d  alpha

omega = ones(2*em,1);
f = [omega;zeros(em,1);zeros(m,1)];
%
% alpha 1 = cx*
aeq1 = [zeros(1,2*em),zeros(1,em),ones(1,m)];
beq1 = -optimalvalue;
% d x0 = cx*
aeq2 = [zeros(1,2*em),xvector',zeros(1,m)];
beq2 = -optimalvalue;
% d-c = tau-eta
aeq3 = [-eye(em),eye(em),eye(em),zeros(em,m)];
beq3 = -w;
LB = [zeros(2*em,1);-Inf*ones(em+m,1)];
%% separation
aineq = [];
bineq = [];
epsi = -1;
while epsi<-0.001
    [X,finaladj] = linprog(f,aineq,bineq,[aeq1;aeq2;aeq3],[beq1;beq2;beq3],LB,[]);
    alpha = X((3*em+1):(3*em+m));
    d = X((2*em+1):(3*em));
    wnew = d;
    for i=1:em
        wnew(i) = wnew(i)-alpha(edge(i,1))-alpha(edge(i,2));
    end
    edgenew = [edge(:,1),edge(:,2),-wnew];
    [ xvectornew,valuevectornew ] = SolveWM(m,edgenew);
    xadd = xvectornew;
    yadd = zeros(m,1);
    for i=1:em
        if xadd(i)==1
            yadd(edgenew(i,1))=1;
            yadd(edgenew(i,2))=1;
        end
    end
    aineqadd = [zeros(1,2*em),-xadd',yadd'];
    aineq = [aineq;aineqadd];
    bineqadd = 0;
    bineq = [bineq;bineqadd];
    epsi = -sum(valuevectornew);
end
edgefinal = [edge(:,1),edge(:,2),-d];
[ xfinal,valuefinal ] = SolveWM(m,edgefinal);
optimalvaluefinal = sum(valuefinal);



wcompare = [edge(:,3),edgefinal(:,3),edge(:,3)-edgefinal(:,3)];
xinverse=abs(wcompare(:,3));


adjnum = 0;
for i=1:em
    if abs(wcompare(i,3))>0.01
        adjnum = adjnum+1;
    end
end
adjpernum = 100*adjnum/em;
adjpervalue = 100*finaladj/sum(w);
adjperopt = 100*finaladj/optimalvalue;


if abs(optimalvalue - optimalvaluefinal)<0.001
    fprintf( 'consistency')
else
    ds
end
if abs(optimalvalue - sum(xfinal.*(-d)))<0.001
    fprintf( '  optimality')
else
    optimalvalue - sum(xfinal.*(-d))
    ds
end
end

