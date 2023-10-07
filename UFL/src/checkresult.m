function [ output_args ] = checkresult

a=load('UFL_ResultRange_Table5_80.txt');
[m,n]=size(a);
a2=a(:,2);
a3=a(:,3);
a4=a(:,4);

anew=[];
for i=1:m
    if a2(i)>0.0001
        anew=[anew;a(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2)
DVmax=max(a2)
DVmin=min(a2)
DNav=sum(a3)/length(a3)
DNmax=max(a3)
DNmin=min(a3)
T=sum(a4)/length(a4)
end

