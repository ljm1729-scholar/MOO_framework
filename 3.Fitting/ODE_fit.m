function X = ODE_fit(t,X0,param,div_date,Re0,kappa,alpha,gamma,f)
%ode45(@ODE_fit,FittingTime,[X0,0],[],x,FittingDividingPoint,beta,kappa,alpha,gamma,f)
mu_input = [param(1:length(div_date))];
tau = param(end-1);
xi = param(end);


mu = interp1(div_date,mu_input,t);

S=X0(1); E=X0(2); I=X0(3); Q=X0(4); R=X0(5); D=X0(6); fit1=X0(7); fit2=X0(8); fit3=X0(9);
N=sum(X0([1,2,3,5]));


dS = -(1-mu)*Re0*alpha/(1-tau)*S*I/N;
dE = +(1-mu)*Re0*alpha/(1-tau)*S*I/N -kappa*E +xi;
dI = +kappa*E -alpha/(1-tau)*I;
dQ = +alpha/(1-tau)*I -gamma*Q;
dR = (1-f)*gamma*Q;
dD = (f)*gamma*Q;

dfit1 = (1-mu)*Re0*alpha/(1-tau)*S*I/N; % cumulative infected
dfit2 = f*gamma*Q; % cumulative death
dfit3 = alpha/(1-tau)*I; % cumulative confirmed

X = [
    dS;
    dE;
    dI;
    dQ;
    dR;
    dD;
    dfit1;
    dfit2;
    dfit3;
       ];