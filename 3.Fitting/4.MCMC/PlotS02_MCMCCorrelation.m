for i=1:length(MCMC.params)
    ParameterName{i} = MCMC.params{i}{1};
end
figure(504) 
set(gcf,"Name","The posterior distribution and correlation of estimated parameters")
clf
CorrValue=corr(trimedMCMCchain);
heatmap(abs(CorrValue))
set(gca,"XData",ParameterName,"YData",ParameterName)

%% Save figure
    Filename_MCMCcorrelation = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_transition.png'];
    exportgraphics(figure(504),Filename_MCMCcorrelation,'Resolution',600)
    Filename_MCMCcorrelation = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_transition.eps'];
    exportgraphics(figure(504),Filename_MCMCcorrelation,'Resolution',600)
    Filename_MCMCcorrelation = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_transition.pdf'];
    exportgraphics(figure(504),Filename_MCMCcorrelation,'Resolution',600)
    Filename_MCMCcorrelation = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_transition.jpg'];
    exportgraphics(figure(504),Filename_MCMCcorrelation,'Resolution',600)
