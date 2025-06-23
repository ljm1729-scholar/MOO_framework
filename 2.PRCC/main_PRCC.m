

%% Sample size N
runs=100000;

%% LHS MATRIX
% modify here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PRCC_parameter_setting;

%xi,beta,mu,kappa,alpha,tau,gamma,f

%Para_LHS = LHS_Call(xmin, xmean ,xmax, xsd   ,nsample, distrib,    threshold)
xi_LHS    = LHS_Call(eps , xi    , 1  , 0     ,runs   , 'unif'); 
R_0_LHS  = LHS_Call(eps , R_0  , 6  , 0     ,runs   , 'unif'); 
mu_LHS    = LHS_Call(eps , mu    , 1  , 0     ,runs   , 'unif'); 
kappa_LHS = LHS_Call(eps , kappa , 1  , 1/14  ,runs   , 'unif'); 
alpha_LHS = LHS_Call(eps , alpha , 1  , 1/14  ,runs   , 'unif'); 
tau_LHS   = LHS_Call(eps , tau   , 1  , 0     ,runs   , 'unif'); 
gamma_LHS = LHS_Call(eps , gamma , 1  , 1/180 ,runs   , 'unif');
f_LHS     = LHS_Call(eps , f     , 1  , 0     ,runs   , 'unif');
dummy_LHS = LHS_Call(eps , 0.1   , 1  , 0     ,runs   , 'unif');

%% LHS MATRIX and PARAMETER LABELS
% modify here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LHSmatrix = [xi_LHS R_0_LHS mu_LHS kappa_LHS alpha_LHS tau_LHS gamma_LHS f_LHS dummy_LHS];

for x=1:runs
    % display the PRCC progress
    if rem(x*10,runs)==0
        home; disp(['PRCC progression: ',num2str(x/runs*100),'%'])
    end

    [t,X]=ode45(@ODE_sensitivity,t,y,[],LHSmatrix(x,1),LHSmatrix(x,2),LHSmatrix(x,3),LHSmatrix(x,4),LHSmatrix(x,5),LHSmatrix(x,6),LHSmatrix(x,7),LHSmatrix(x,8));
    A=[t X];
    
    T_lhs(:,x)=A(time_points+1,1);
    S_lhs(:,x)=A(time_points+1,2);
    E_lhs(:,x)=A(time_points+1,3);
    I_lhs(:,x)=A(time_points+1,4);
    Q_lhs(:,x)=A(time_points+1,5);
    R_lhs(:,x)=A(time_points+1,6);
    D_lhs(:,x)=A(time_points+1,7);
    Cumul_Infection_lhs(:,x)=A(time_points+1,8);
    Cumul_Confirm_lhs(:,x)=A(time_points+1,10);
end

something=0.05;

[prcc1,sign1]=PRCC(LHSmatrix,Cumul_Infection_lhs,1:length(time_points),PRCC_var,something);

PlotPRCC.prcc1 = prcc1;
PlotPRCC.sign1 = sign1;
PlotPRCC.TimeIdx = 1:length(time_points);
PlotPRCC.alpha = something;
PlotPRCC.PRCC_var = PRCC_var;


[prcc2,sign2]=PRCC(LHSmatrix,Cumul_Confirm_lhs,1:length(time_points),PRCC_var,something);

PlotPRCC.prcc2 = prcc2;
PlotPRCC.sign2 = sign2;
PlotPRCC.TimeIdx = 1:length(time_points);
PlotPRCC.alpha = something;
PlotPRCC.PRCC_var = PRCC_var;




%[prcc,sign]=PRCC(LHSmatrix,Cumul_Infection_lhs,1:length(time_points),PRCC_var,something);

% rcc_plot=RCC_PLOT(LHSmatrix,Cumul_Confirm_lhs,1,'lin',PRCC_var,y_var_label{end})
% CC_PLOT(LHSmatrix,Cumul_Confirm_lhs,22,'lin',PRCC_var,y_var_label{end})