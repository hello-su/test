function [edge] = GenerateWM(m)
%% generate weighted maching problem instance
    em = m*(m-1)/2;
    w = randi([1,100],em,1);
    edge = [zeros(em,2),w];
    eind = 0;
    for i=1:m
        for  j=(i+1):m
            eind = eind+1;
            edge(eind,1)=i;
            edge(eind,2)=j;
        end
    end
end

