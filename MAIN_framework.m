%% %%%%%%%%%%%%%%%%%% Add Function Directories %%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear; clc;
addpath(genpath(pwd))
%NameOfCountry
%%
% Generate the "timestone" variabjle which record the time
timestone = RecordTime("Start"); % Initialize time record

%% %%%%%%%%%%%%%%%%%% Preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocess
Initialization

%% %%%%%%%%%%%%%%%%%% PRCC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRCC
DoPRCC = 0;
if DoPRCC == 1
    main_PRCC
    
    Plot02_PRCC
else
end

%% %%%%%%%%%%%%%%%%%% IMODE estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMODE initial setting
MakingFunctionHandle

% IMODE calculation: Parellel computing
parfor iter = 1:100
    lb = [0*ones(1,FittingNumberOfMu),0.4,0];
    ub = [0.95*ones(1,FittingNumberOfMu),0.6,1]; ub(1) = 0; ub(2) = 0; ub(end)=1;
    
    IMODE_Results=IMODE_basic(ObjIMODE,FittingNumberOfMu+2,lb,ub,1.0e+5);
    IMODE_search(iter,:) = [ObjIMODE(IMODE_Results),IMODE_Results];
    disp(['IMODE iteration: ',num2str(iter)])
end
[~,IMODE_index] = sort(IMODE_search(:,1));
IMODE_search = IMODE_search(IMODE_index,:); 
IMODE_Results = IMODE_search(1,2:end);
Filename_IMODE_Data = ['Results/IMODE_Results/IMODE_Results_',char(CountryName),'.mat'];
save(Filename_IMODE_Data,'IMODE_search','IMODE_Results','-v7.3')

% plot the IMODE parameter estimation results
PlotS1_IMODE

%% %%%%%%%%%%%%%%%%%% MCMC process %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MCMC_Setting

[MCMCresults,MCMCchain,MCMCs2chain] = mcmcrun(model,Info.ydata,MCMC.params,options);

burnin = 0.5;
ChainLength = length(MCMCchain(:,1));
burninIndex = floor(burnin*ChainLength);
lengthOfChain = burnin*ChainLength;
trimedMCMCchain=MCMCchain(burninIndex+1:end,:);
MCMCresults.mean = median(trimedMCMCchain);
DataCountries.MCMCEstimResult=MCMCresults.mean;
MCMC_Results = MCMCresults.mean;
Filename_MCMC_Data = ['Results/MCMC_Results/MCMC_Results_',char(CountryName),'.mat'];
save(Filename_MCMC_Data,'MCMCresults','MCMCchain','MCMCs2chain','trimedMCMCchain','-v7.3')
% plot the MCMC parameter estimation results
PlotS2_MCMC
PlotS02_MCMCCorrelation
PlotS03_MCMCPosteriorDistribution

% Time record 4: MCMC process - making posterior distribution for the parameters
timestone = RecordTime("MCMC",timestone);


%% multi-objective optimization simulation
MOO_setting
[MultiObjResult,NumDuplications]  = multiObjSimulation(SimNum,obj,SimulNumberOfMu,lb,ub,GAoptions);

% save3: the multi-objective optimization results
Filename_Multiobj_Data = ['Results/Multiobj_Results/Multiobj_Results_',char(CountryName),'.mat'];
save(Filename_Multiobj_Data,'MultiObjResult')


% multi objective results
Plot04_MultiObj_NoData

%% Cost-benefit analysis

% Save all the results
Filename_Simul_Data = ['Results/Simul_Results/Simul_Results_',char(CountryName),'.mat'];
save(Filename_Simul_Data,'-v7.3')

Plot05_CostBenefit

Plot06_CostOptimalPattern
    


