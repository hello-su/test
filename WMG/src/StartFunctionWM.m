function [ output_args ] = StartFunctionWM(n,option)
% n is the number of nodes
% en is the number of arcs
% edge is the matrix of the bipartite graph
% w is the vector of weight
% xstar is the optimal solution of c(V)
% optimalvalue is the value of c(V)
% t is the computational time
% edgefinal is the new matrix of the bipartite graph with new edge weight
% DN in table 2
% DV in table 2
% T in table 2
%% weighted maching game
for kk=1:100


    if option==1
        %% generate random instances for general purposes
        tic
        [edge]=GenerateWM(n);
        %% solve mscimum weighted matching
        [xstar,optimalvalue] = SolveWM(n,edge);
        t1=toc;
        dlmwrite([strcat('WM_Instance_',num2str(n),'_',num2str(kk),'.txt')], [edge,xstar], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('WM_Instance_',num2str(n),'_',num2str(kk),'.txt')], [optimalvalue], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('WM_Instance_',num2str(n),'_',num2str(kk),'.txt')], [t1], 'precision', '%.3f', 'newline', 'pc','-append');


        %% input existing WM instances and solve WM inverse cost adjustment for recurrence
        %% table 2
    elseif option==2
        tic
        dataread=dlmread(strcat('WM_Instance_',num2str(n),'_',num2str(kk),'.txt'));
        [DN,DV,totaladjcost,edgefinal,xinverse]=InvCostAdjWM(n,dataread);
        t2 = toc;

        dlmwrite([strcat('WM_Result_',num2str(n),'_',num2str(kk),'.txt')], [edgefinal,xinverse], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('WM_Result_',num2str(n),'_',num2str(kk),'.txt')], [totaladjcost], 'precision', '%.3f', 'newline', 'pc','-append');
        %dlmwrite([strcat('Result_Table2_',num2str(n),'_',num2str(kk),'.txt')], [kk,DV,DN,t], 'precision', '%.3f', 'newline', 'pc','-append')
        dlmwrite([strcat('WM_Result_Table2_',num2str(n),'.txt')], [kk,DV,DN,t2], 'precision', '%.3f', 'newline', 'pc','-append');
        kk

        %% input existing WM instances and solve WM inverse cost adjustment for recurrence with range
        %% table 3
    elseif option==3
        tic
        dataread=dlmread(strcat('WM_Instance_',num2str(n),'_',num2str(kk),'.txt'));
        [DNR,DVR,totaladjcostR,edgefinalR,xinverseR]=InvCostAdjWMRange(n,dataread);
        t3 = toc;

        dlmwrite([strcat('WM_ResultRange_',num2str(n),'_',num2str(kk),'.txt')], [edgefinalR,xinverseR], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('WM_ResultRange_',num2str(n),'_',num2str(kk),'.txt')], [totaladjcostR], 'precision', '%.3f', 'newline', 'pc','-append');
        %dlmwrite([strcat('Result_Table2_',num2str(n),'_',num2str(kk),'.txt')], [kk,DV,DN,t], 'precision', '%.3f', 'newline', 'pc','-append')
        dlmwrite([strcat('WM_ResultRange_Table3_',num2str(n),'.txt')], [kk,DVR,DNR,t3], 'precision', '%.3f', 'newline', 'pc','-append');
        kk
    end
end
%dlmwrite([strcat('ResultInvCA',num2str(kk),'.txt')], [kk,n,adjpernum,adjpervalue,adjperopt,t,finaladj,optimalvalue], 'precision', '%.3f', 'newline', 'pc','-append');
end

