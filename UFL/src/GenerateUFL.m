function [ c,f,c1,mn,data ] = GenerateUFL(m,n)

c1 = randi([1,100],[m*n,1]);

f = randi([100,200],[m,1]);

c = zeros(m,n);
for i=1:m
    c(i,:) = c1(((i-1)*n+1):(i*n),1);
end


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
end

