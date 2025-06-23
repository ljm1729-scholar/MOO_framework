figure(502)
set(gcf,"Name","[Bayesian Inference] Fitting result",'Units','centimeters','Position',[0,0,25,12])
clf
title(CountryName)
tiledlayout(2,1,'Padding','compact','TileSpacing','compact')
nexttile(1)
[~,X] = ode45(@ODE_fit,FittingTime,[X0,0,0,0],[],[0,0,MCMCresults.mean],FittingDividingPoint,Re0,kappa,alpha,gamma,f);
hold on
plot(DataTime,DataCase,'ro','MarkerSize',5)
plot(FittingTime,X(:,end),'k-','LineWidth',1)

ylabel(["Cumulative";"confirmed cases"])
ylim([0,DetermineYlim(X(end,end))])
xlim([FittingTime(1),FittingTime(end)])
XTick = FittingDividingPoint; XTickLabel = datestr(XTick,'mmm dd, yyyy');
set(gca,'TickDir','Out','TickLabelInterpreter','tex',...
    'FontSize',12,'FontName','Times',...
    'XTick',XTick,'XTickLabel',[])
legend('Cumulative confirmed case data','Simulation result with estimated parameters','Location','northwest','FontSize',10)
%%
nexttile(2)

hold on
plot(FittingDividingPoint,[0,0,MCMCresults.mean(1:end-2)],'k-','LineWidth',1)
mu_in=[0,0,MCMCresults.mean(1:end-2)];
for i=1:FittingNumberOfMu
    if i==1 || i==2
        plot(FittingDividingPoint(i),mu_in(i),'bo','MarkerFaceColor','b')
    else
        plot(FittingDividingPoint(i),mu_in(i),'ro','MarkerFaceColor','r')
    end
end
xlim([FittingTime(1),FittingTime(end)])
ylim([0,1])
legend('\mu(t) in the model','\mu before index case','','estimated \mu','Location','best')
set(gca,'TickLabelInterpreter','tex',...
    'XTick',FittingDividingPoint,'XTickLabel',[],... %["-2nd week","Index case","2nd week","4th week","6th week","8th week","10th week","12th week","14th week","16th week","18th week","20th week"]
    'FontSize',12,'FontName','Times')
ylabel("Transmission reduction (\mu(t))")
XTickLabel_MCMC = [" "]; XTickLabel_MCMC(FittingNumberOfMu) = [" "]; 
for i=1:FittingNumberOfMu
    XTickLabel_MCMC(i) = [num2str((i-2)*2),'w'];
end
XTickLabel_MCMC(2) = ["Idx"];

set(gca,'TickLabelInterpreter','tex',...
    'XTick',FittingDividingPoint,'XTickLabel',XTickLabel_MCMC,...
    'FontSize',12,'FontName','Times','XTickLabelRotation',90)
xlabel({'Time from the index case'})


%% Save figure
    Filename_IMODE = ['Results/Figures/MCMC/FigureS2_',char(CountryName),'.png'];
    exportgraphics(figure(502),Filename_IMODE,'Resolution',600)
    Filename_IMODE = ['Results/Figures/MCMC/FigureS2_',char(CountryName),'.eps'];
    exportgraphics(figure(502),Filename_IMODE,'Resolution',600)
    Filename_IMODE = ['Results/Figures/MCMC/FigureS2_',char(CountryName),'.pdf'];
    exportgraphics(figure(502),Filename_IMODE,'Resolution',600)
    Filename_IMODE = ['Results/Figures/MCMC/FigureS2_',char(CountryName),'.jpg'];
    exportgraphics(figure(502),Filename_IMODE,'Resolution',600)
