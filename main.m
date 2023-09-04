%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%adding all the folders and subfolders to path
clear
clc
addpath(genpath(pwd))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%code for connecting all submodels for the three defined SHMs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load('Data.mat') %data file is not shared due to restrictions from the data provider
%Users may contact the author for data file (Sai Veena: saiveena26@gmail.com)

Q2 = Data.Q(25:1104,4)*214185*0.001;%select 1968 june to 2013 May
Q2_month = sum(reshape(Q2,2,[]));%fortnight data converted to monthly

n_year  = 45;%number of year of simulation

%load rainfall data
load('rainfall_CA2_hist') %original data from 1901 to 2015
rainfall_CA2 = FN_dataf(1619:2626+24*3);%extract data from 1968 to 2013
rainfall_CA2_month = sum(reshape(rainfall_CA2,2,[]));

%load potential evaporation data
load('PE_CA_hist.mat')
PE_CA2 = FN_PE(419:1426+24*3);%extract data from 1968 to 2013
PE_CA2_month = sum(reshape(PE_CA2,2,[]));

%run model for SHM1
result1 = eval_objs_GW_Recipient_CLD1(Q2_month,n_year,rainfall_CA2_month,PE_CA2_month);
stor(:,1) = result1.storage(381:540)';
result=result1;
save resultcld1 result

%run model for SHM2
result2 = eval_objs_GW_Recipient_CLD2(Q2_month,n_year,rainfall_CA2_month,PE_CA2_month);
stor(:,2) = result2.storage(381:540)';
gw (:,1) = result2.GW(467:540)';
result=result2;
save resultcld2 result

%run model for SHM3
result3 = eval_objs_GW_Recipient_CLD3(Q2_month,n_year,rainfall_CA2_month,PE_CA2_month);
stor(:,3) = result3.storage(381:540)';
gw (:,2) = result3.GW(467:540)';
result=result3;
save resultcld3 result
result.date = Data.Q(25:2:1104,1:2);

