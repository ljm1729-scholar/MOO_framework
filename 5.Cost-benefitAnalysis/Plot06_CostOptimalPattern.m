%%
BigChangeIndextrim=BigChangeIndex;
BigChangeIndextrim([2,4,5,6,7,8,9])=[]
figure(6)
set(gcf,"Name","CBA results for CpI",'Units','centimeters','Position',[0,0,25,8])
clf
tiledlayout(length(BigChangeIndextrim(1:end-1)),2,'Padding','compact','TileSpacing','compact'); 

%% 
for i=1:length(BigChangeIndextrim(1:end-1))
    nexttile(2*(length(BigChangeIndextrim(1:end-1))+1-i))
    hold on
    plot(1:SimulNumberOfMu,[zeros(1,2),MultiObjResult.x(OptimIndexX(BigChangeIndextrim(i)),:)],'-','LineWidth',2,'Color',FigInfo.CostOptimalColor(mod(i,4)+1,:))
    xlim([1 SimulNumberOfMu])
    ylim([0 1])
    set(gca,'TickDir','Out',...
    'XTick',1:SimulNumberOfMu,'XTickLabel',[],...
    'YTick',[0,1],'YTickLabel',[],...
    'YGrid','on')
    %YTickLabelIndex(i) = CPlot.CIvec(OptimIndexY(BigChangeIndex(i)))/CpI;
end

nexttile(2*(length(BigChangeIndextrim(1:end-1))))
xlabel('Time from the index case')
set(gca,'TickDir','Out', ...
    'XTick',1:SimulNumberOfMu,'XTickLabel',XTickLabel_Multiobj,'XTickLabelRotation',90,...
    'YGrid','on',...
    'FontSize',12,'FontName','Times')
nexttile(2)

%%
nexttile(1,[length(BigChangeIndextrim(1:end-1)),1])
hold on

Surf2Z = [zeros(length(CPlot.CIvec),2),MultiObjResult.x(OptimPoints(:,4),:)];
Surf2Z_interp=zeros(length(Surf2Z(:,1)),length(1:0.01:length(Surf2Z(1,:))));
for i=1:length(Surf2Z(:,1))
    Surf2Z_interp(i,:) = interp1(1:length(Surf2Z(1,:)),Surf2Z(i,:),1:0.01:length(Surf2Z(1,:)));
end
[Surf2X,Surf2Y] = meshgrid(((1:0.01:length(Surf2Z(1,:)))-1)*14+min(SimulDividingPoint),CPlot.CIvec);
surf(Surf2X,Surf2Y,Surf2Z_interp,'EdgeColor','none')
clear('Surf2X','Surf2Y','Surf2Z','Surf2Z_interp')
ylabel('Cost per infection (US $)')
xlim([min(SimulDividingPoint),max(SimulDividingPoint)])
xlabel('Time from the index case')
mymapp = zeros(255,3);
for i=1:255
    mymapp(i,:) = (255-i)/255*[9,55,33]/255 +i/255*[37,220,138]/255;
end
colormap(gca,mymapp)
cb = colorbar;
cb.Ticks = [0,0.2,0.4,0.6,0.8];
cb.TickLabels = {'0','0.2','0.4','0.6','0.8'};
cb.FontSize = 12;
cb.Limits = [0,1];
clear cb
set(gca,'YScale','log','TickDir','Out',...
        'XTick',SimulDividingPoint,'XTickLabel',XTickLabel_Multiobj,'XTickLabelRotation',90,...
        'YTick',[1.0e-6,1.0e-5,1.0e-4,1.0e-3,1.0e-2],'YTickLabel',{"1K","10K","100K","1M","10M"},...
        'ZTick',[0,0.2,0.4,0.6,0.8],'ZTickLabel',{'0','0.2','0.4','0.6','0.8'},...
        'FontSize',12,'FontName','Times')

Filename_MultiObj = ['Results/Figures/MultiObj/Figure4c_',char(CountryName),'.png'];
exportgraphics(figure(6),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4c_',char(CountryName),'.eps'];
exportgraphics(figure(6),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4c_',char(CountryName),'.pdf'];
exportgraphics(figure(6),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4c_',char(CountryName),'.jpg'];
exportgraphics(figure(6),Filename_MultiObj,'Resolution',600)


%% Record time
% Time record 6: Cost-benefit analysis
timestone = RecordTime("Cost-benefit analysis",timestone);