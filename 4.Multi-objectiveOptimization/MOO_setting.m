
tau = MCMC_Results(end-1);
xi = MCMC_Results(end);
lb=zeros(1,SimulNumberOfMu-2); ub=0.95+0*zeros(1,SimulNumberOfMu-2);

obj=@(x) [meanmean(x),log10(OBJ_optim_inf(x,SimulTime,X0,SimulDividingPoint,Re0,xi,kappa,alpha,gamma,f,tau))];
SimNum = 200;
GAoptions = optimoptions('gamultiobj','PopulationSize',1000,'ParetoFraction',0.5,'MaxTime',6*3600,'MaxGenerations',13*10000,'ConstraintTolerance',1e-8,'Display','final','UseParallel',true);
