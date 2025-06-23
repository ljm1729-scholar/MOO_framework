function Y=OBJ_optim_inf_prospective(mu,time,X0,div_date,beta,xi,kappa,alpha,gamma,f,tau,mu0)
opts = odeset('NonNegative',1);
[~,X] = ode45(@ODE_optim_pro,time,X0,[],div_date,mu,beta,xi,kappa,alpha,gamma,f,tau,mu0);

Y=X(end,end-2);
