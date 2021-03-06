clear all;
clc;

global savestate Gvars nObjectives smallN input

smallN = 1e-6;

config
userInput
initControlVars(input)

LB=zeros(1,Nvariables);
UB=100*ones(1,Nvariables);
bounds=[LB,UB];

savestate = [];
if(~isempty(restartFromFile))
    load(restartFromFile);
    aux =  savestate{end};
    popInit = savestate{end}.Population;    
    scoreInit = savestate{end}.Score;
    savestate = [];
    savestate{1} = aux;
else
    popInit = [];    
    scoreInit = [];
end

% fitness function
fitnessFunction = @fitness_out;

%Start with default options
options = gaoptimset;
%%Modify some parameters
options = gaoptimset(options,'Generations' ,nGenera);
options = gaoptimset(options,'StallGenLimit' ,nGenera);
options = gaoptimset(options,'EliteCount', EliteCount);
options = gaoptimset(options,'CrossoverFraction', 0.8);
options = gaoptimset(options,'PopInitRange' ,[LB;UB]);
options = gaoptimset(options,'InitialPopulation' ,popInit);
options = gaoptimset(options,'InitialScores' ,scoreInit);
options = gaoptimset(options,'PopulationSize' ,PopSize);
options = gaoptimset(options,'StallTimeLimit' ,Inf);
options = gaoptimset(options,'MutationFcn' ,@mutationgaussianRangeU);
options = gaoptimset(options,'Display' ,'off');
options = gaoptimset(options,'OutputFcns' ,{@gaoutputfcnFSIwing});
options = gaoptimset(options,'CrossoverFcn',@crossoverscattered);
options = gaoptimset(options,'Vectorized','off');
options = gaoptimset(options,'PlotFcns',@gaplotpareto);

%%Run GA multiobjective
if(nObjectives>1)
   % [X,FVAL,REASON,OUTPUT,POPULATION,SCORE] = gamultiobj(fitnessFunction,Nvariables,[],[],[],[],[],[],options);
else
   % [X,FVAL,REASON,OUTPUT,POPULATION,SCORE] = ga(fitnessFunction,Nvariables,options);
end

save BestInd X FVAL REASON OUTPUT POPULATION SCORE

