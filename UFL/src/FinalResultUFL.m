function [ table4, table5 ] = FinalResultUFL

err=0.0001;
data1=load('UFL_Result_Table4_20.txt');
data2=load('UFL_Result_Table4_40.txt');
data3=load('UFL_Result_Table4_60.txt');
data4=load('UFL_Result_Table4_80.txt');
data5=load('UFL_ResultRange_Table5_20.txt');
data6=load('UFL_ResultRange_Table5_40.txt');
data7=load('UFL_ResultRange_Table5_60.txt');
data8=load('UFL_ResultRange_Table5_80.txt');


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

table4_1=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table4_2=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table4_3=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table4_4=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

table4=[table4_1;table4_2;table4_3;table4_4];

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

table5_1=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table5_2=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table5_3=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

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

table5_4=[length(a2), DVav, DVmax, DVmin, DNav, DNmax, DNmin, T];

table5=[table5_1;table5_2;table5_3;table5_4];

end

