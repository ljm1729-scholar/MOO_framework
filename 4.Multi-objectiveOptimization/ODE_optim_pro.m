function X = ODE_optim_pro(t,X0,div_date,mu_input,beta,xi,kappa,alpha,gamma,f,tau,mu0)
mu_input = [mu0,mu_input];
% linear interpolation of mu
t_idx=sum(div_date(1:end-1)<=t);
mu=(mu_input(t_idx+1)*(t-div_date(t_idx))...
    + mu_input(t_idx)*(div_date(t_idx+1)-t))/...
    (div_date(t_idx+1)-div_date(t_idx));

% f_tri = @(t,x,a,b) x.*( (t>=(a-(b-a)/2) & t<=(b-(b-a)/2)).*(t-(a-(b-a)/2))./(b-a) ...
%                       +(t>(a+(b-a)/2) & t<(b+(b-a)/2)).*((b+(b-a)/2)-t)./(b-a)      );
% mu = @(t) sum(f_tri(t,mu_input,dividing_date(1:end-1),dividing_date(2:end)));
% assign values to the parameters
S=X0(1); E=X0(2); I=X0(3); Q=X0(4); R=X0(5); D=X0(6); fit1=X0(7); fit2=X0(8); fit3=X0(9);
N=sum(X0) -Q -fit1 -fit2 -fit3;

dS = -(1-mu)*beta*S*I/N;
dE = +(1-mu)*beta*S*I/N -kappa*E +xi;
dI = +kappa*E -alpha/(1-tau)*I;
dQ = +alpha/(1-tau)*I -gamma*Q;
dR = (1-f)*gamma*Q;
dD = (f)*gamma*Q;

dfit1 = (1-mu)*beta*S*I/N; % cumulative infected
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