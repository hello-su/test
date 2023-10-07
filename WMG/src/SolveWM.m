function [xvector,optimalvalue] = SolveWM(m,edge)

%% initial
em = m*(m-1)/2;
pairsind = PairIndex(edge,0);
%% process
if max(edge(:,3))<0
    pairsnewind = -ones(1,m);
    for i=1:m
        if pairsind(i)>0
            pairsnewind(i)=pairsind(i);
            pairsnewind(pairsind(i))=pairsind(pairsind(i));
            break
        end
    end
    pairsind = pairsnewind;
end
xmatrix = zeros(m,m);
for i=1:m
    if i<pairsind(i)
        xmatrix(i,pairsind(i))=1;
    end
end

xvector = zeros(em,1);
ind = 0;
for i=1:m
    for j=(i+1):m
        ind = ind+1;
        xvector(ind) = xmatrix(i,j);
    end
end

wmatrix = zeros(m,m);
for i=1:em
    wmatrix(edge(i,1),edge(i,2))=edge(i,3);
end
valuematrix = wmatrix.*xmatrix;
valuevector = xvector.*edge(:,3);
optimalvalue = sum(valuevector);
end