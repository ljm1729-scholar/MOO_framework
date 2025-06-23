function ss = OBJ_MCMC_fit(para_estim,ObjData,DataTime,FittingTime,X0,FittingDividingPoint,beta,kappa,alpha,gamma,f)
% model.ssfun = @(A,B) OBJ_MCMC_fit(A,B,DataTime,FittingTime,X0,FittingDividingPoint,beta,kappa,alpha,gamma,f);
[~,X] = ode45(@ODE_fit,FittingTime,[X0,0,0,0],[],[0,0,para_estim],FittingDividingPoint,beta,kappa,alpha,gamma,f);
ObjModel = X(DataTime-FittingTime(1),end);

ss = sqrt(sum((ObjData-ObjModel).^2));