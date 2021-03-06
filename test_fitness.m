close all
clear all

global Gvars input smallN

smallN = 1e-6;

config
userInput
initControlVars(input)

LB=zeros(1,Nvariables);
UB=100*ones(1,Nvariables);
bounds=[LB,UB];

x = (UB-LB).*rand(1,Nvariables)+LB;

%% Evaluate Fitness

%[CL_ave,CT_ave,CP_ave,eff,mass,peak_disp] = evaluate_fitness(x);
fname = tempname;
while exist(fname, 'file');
    fname = tempname;
end
fid = fopen(fname, 'wt');

fprintf(fid, '%f', x);
fclose(fid);

[status,result] = system(['evaluate_fitness.exe < ' fname])