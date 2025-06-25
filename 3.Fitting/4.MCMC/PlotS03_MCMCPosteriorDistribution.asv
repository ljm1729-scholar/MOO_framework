NumberOfParameter=length(trimedMCMCchain(1,:));
CuttingNumber=100;
for ii=1:NumberOfParameter
    ubPlot(ii)=max(MCMCchain(:,ii)); lbPlot(ii)=min(MCMCchain(:,ii));
    unit(ii)=(ubPlot(ii)-lbPlot(ii))/CuttingNumber;
    for j=1:CuttingNumber+1
        NumberOfBar(j)=sum(trimedMCMCchain(:,ii)>=(lbPlot(ii)+(j-1)*unit(ii)) & trimedMCMCchain(:,ii)<lbPlot(ii)+j*unit(ii));
    end
    BarGraphParameter{ii}=NumberOfBar/lengthOfChain;
end

figure(503)
set(gcf,"Name","MCMC chain")
clf
tileChain = tiledlayout(6,10,"TileSpacing","tight","Padding","tight");
title(CountryName)
for i = 1:length(MCMCchain(1,:))
    nexttile(2*i-1)
    hold on
    plot(1:burninIndex,MCMCchain(1:burninIndex,i),'r')
    plot(burninIndex+1:length(MCMCchain(:,i)),MCMCchain(burninIndex+1:end,i),'k')
    title(ParameterName{i})
    set(gca,'XTick',[0,length(MCMCchain(:,1))/2,length(MCMCchain(:,1))],'XTickLabel',["0","5.0e+5","1.0e+6"],'XTickLabelRotation',0)
    nexttile(2*i)
    barh(BarGraphParameter{i},'EdgeColor','none','BarWidth',1,'FaceColor',[0.5,0.5,0.5])
    set(gca,'YTick',[],'YTickLabel',[],'XTick',[],'XTickLabel',[])
    
end

%% Save figure
Filename_MCMCchain = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_chain.png'];
exportgraphics(figure(503),Filename_MCMCchain,'Resolution',600)
Filename_MCMCchain = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_chain.eps'];
exportgraphics(figure(503),Filename_MCMCchain,'Resolution',600)
Filename_MCMCchain = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_chain.pdf'];
exportgraphics(figure(503),Filename_MCMCchain,'Resolution',600)
Filename_MCMCchain = ['Results/Figures/MCMC/Figure03_',char(CountryName),'_MCMC_chain.jpg'];
exportgraphics(figure(503),Filename_MCMCchain,'Resolution',600)


