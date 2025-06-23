function Y=OBJ_optim_ProdPop(mu,time,X0,div_date,Re0,xi,kappa,alpha,gamma,f,tau)
opts = odeset('NonNegative',1);
[~,X] = ode45(@ODE_optim,time,[X0,0,0,0],[],div_date,[0,0,mu],Re0,xi,kappa,alpha,gamma,f,tau);

Y=X0(1)-mean(X(:,end-1));

