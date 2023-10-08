function [ table2, table3 ] = FinalResultWM

err=0.0001;
data1=load('WM_Result_Table2_30.txt');
data2=load('WM_Result_Table2_40.txt');
data3=load('WM_Result_Table2_50.txt');
data4=load('WM_Result_Table2_60.txt');
data5=load('WM_ResultRange_Table3_30.txt');
data6=load('WM_ResultRange_Table3_40.txt');
data7=load('WM_ResultRange_Table3_50.txt');
data8=load('WM_ResultRange_Table3_60.txt');


%%
[m,n]=size(data1);
a2=data1(:,2);
a3=data1(:,3);
a4=data1(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data1(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table2_1=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data2);
a2=data2(:,2);
a3=data2(:,3);
a4=data2(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data2(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table2_2=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data3);
a2=data3(:,2);
a3=data3(:,3);
a4=data3(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data3(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table2_3=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data4);
a2=data4(:,2);
a3=data4(:,3);
a4=data4(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data4(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table2_4=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

table2=[table2_1;table2_2;table2_3;table2_4];

%%=============================================
%%
[m,n]=size(data5);
a2=data5(:,2);
a3=data5(:,3);
a4=data5(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data5(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table3_1=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data6);
a2=data6(:,2);
a3=data6(:,3);
a4=data6(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data6(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table3_2=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data7);
a2=data7(:,2);
a3=data7(:,3);
a4=data7(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data7(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table3_3=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

%%
[m,n]=size(data8);
a2=data8(:,2);
a3=data8(:,3);
a4=data8(:,4);

anew=[];
for i=1:m
    if a2(i)>err
        anew=[anew;data8(i,:)];
    end
end

a2=anew(:,2);
a3=anew(:,3);
a4=anew(:,4);

DVav=sum(a2)/length(a2);
DVmax=max(a2);
DVmin=min(a2);
DNav=sum(a3)/length(a3);
DNmax=max(a3);
DNmin=min(a3);
T=sum(a4)/length(a4);

table3_4=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

table3=[table3_1;table3_2;table3_3;table3_4];

end