pop=51710000;
xi = 0.5;
R_0 = 2.87;
mu = 0.5;
kappa = 1/4;
alpha = 1/10;
tau = 0.5;
gamma = 1/14;
f = 0.0173;

change = linspace(0,40*14,41);

S0 = pop; E0 = 0; I0 = 0; Q0 = 0; R0 = 0; D0 = 0;
y = [S0,E0,I0,Q0,R0,D0,0,0,0];

PRCC_var={'\xi','R_0','\mu','\kappa','\alpha','\tau','\gamma','f','dummy'};

t_end = 40*14;
t = (0:t_end)'; 
time_points=7:7:t_end;

y_var_label={'S','E','I','Q','R','D','Cumul Infection','Cumul Confirm'};
