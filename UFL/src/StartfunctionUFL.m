function [ output_args ] = StartfunctionUFL(m,n,option)
% f is the facility opening cost
% c is the service cost
% v is the decision variable of f
% u is the decision variable of u
% m is the number of facilities
% n is the number of customers
% option: 1 is to generate and save random instances
%         2 is to use generated instances to compute CIOP for UFL
%         3 is to use generated instances to compute CIOP for UFL with range
%         4 is to compute the final results for Tables 2 and 3

for kk=1:100

    format short g
    if option==1
        %% GenerateUFL function is to generate randomized facilition instances and compute the optimal solution by GUROBI
        [c,f,c1]=GenerateUFL(m,n);
        %% NetworkGurobi function is to compute the optimal solution of UFL instance by GUROBI
        [v,u,ObjUFL,ObjBoundUFL,TimeUFL,ResultUFL] = NetworkGurobi(m,n,c1,f);
        %% save exisiting instances for recurrence
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [c], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [u], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [f'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [v'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [ObjUFL], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [ObjBoundUFL], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt')], [TimeUFL], 'precision', '%.3f', 'newline', 'pc','-append');

        %% input existing UFL instances and solve UFL inverse cost adjustment for recurrence
        %% table 4
    elseif option==2
        dataread=dlmread(strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt'));
        tic
        [DV,DN,cfinal,uinvrse,ffinal,vinvrse,totaladjcost] = InvCostAdjUFL(m,n,dataread);
        t = toc
        dlmwrite([strcat('UFL_Result_',num2str(m),'_',num2str(kk),'.txt')], [cfinal], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Result_',num2str(m),'_',num2str(kk),'.txt')], [uinvrse], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Result_',num2str(m),'_',num2str(kk),'.txt')], [ffinal'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Result_',num2str(m),'_',num2str(kk),'.txt')], [vinvrse'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Result_',num2str(m),'_',num2str(kk),'.txt')], [totaladjcost], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_Result_Table4_',num2str(m),'.txt')], [kk,DV,DN,t], 'precision', '%.3f', 'newline', 'pc','-append');

        %% input existing UFL instances and solve UFL inverse cost adjustment for recurrence with range
        %% talble 5
    elseif option==3
        dataread=dlmread(strcat('UFL_Instance_',num2str(m),'_',num2str(kk),'.txt'));
        tic
        [DVR,DNR,cfinalR,uinvrseR,ffinalR,vinvrseR,totaladjcostR] = InvCostAdjUFLRange(m,n,dataread);
        tR = toc
        dlmwrite([strcat('UFL_ResultRange_',num2str(m),'_',num2str(kk),'.txt')], [cfinalR], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_ResultRange_',num2str(m),'_',num2str(kk),'.txt')], [uinvrseR], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_ResultRange_',num2str(m),'_',num2str(kk),'.txt')], [ffinalR'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_ResultRange_',num2str(m),'_',num2str(kk),'.txt')], [vinvrseR'], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_ResultRange_',num2str(m),'_',num2str(kk),'.txt')], [totaladjcostR], 'precision', '%.3f', 'newline', 'pc','-append');
        dlmwrite([strcat('UFL_ResultRange_Table5_',num2str(m),'.txt')], [kk,DVR,DNR,tR], 'precision', '%.3f', 'newline', 'pc','-append');
    end
end

if m==0&&n==0&&option==4
    [table4, table5]= FinalResultUFL;
    dlmwrite(['Table4.txt'], [table4], 'precision', '%.3f', 'newline', 'pc','-append');
    dlmwrite(['Table5.txt'], [table5], 'precision', '%.3f', 'newline', 'pc','-append');
end
end

