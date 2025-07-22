CommandText=['MCMC.params = {'];
for ii=3:FittingNumberOfMu
    CommandText=[CommandText,'{''\mu_{',num2str(ii),'}'', IMODE_Results(',num2str(ii),'), 0, 0.95, IMODE_Results(',num2str(ii),'), 0.05};'];
end
CommandText=[CommandText,'{''\tau'', IMODE_Results(end-1), 0, 1, IMODE_Results(end-1), 0.05};'];
CommandText=[CommandText,'{''\xi'', IMODE_Results(end), 0, 1, IMODE_Results(end), 0.05}'];
CommandText=[CommandText,'};'];
eval(CommandText)

model.ssfun = @(A,B) OBJ_MCMC_fit(A,B,DataTime,FittingTime,X0,FittingDividingPoint,Re0,kappa,alpha,gamma,f);

options.nsimu = 500000;
options.burnintime = 0;
options.updatesigma = 1;
options.waitbar = 1;

Info.xdata = DataTime;
Info.ydata = DataCase;
