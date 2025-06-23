ReducedGDP = 0.04261; % OECD statistics
perGDP = 31902;
VSL = perGDP*0.00005489659367*1.0e+6; % Million dollars
QC = perGDP*0.02;


figure(5)
set(gcf,"Name","CBA results",'Units','centimeters','Position',[0,0,25,8])
tiledlayout(1,2,'Padding','compact','TileSpacing','compact'); 

objProdPop = @(x) OBJ_optim_ProdPop(x,SimulTime,X0,SimulDividingPoint,Re0,xi,kappa,alpha,gamma,f,tau);
for i=1:length(MultiObjResult.fval(:,1))
    MultiObjResult.fval(i,3) = objProdPop(MultiObjResult.x(i,:));
end
DataMultiObj(3) = objProdPop(IMODE_Results(1:SimulNumberOfMu-2));

CpQ = QC/gamma *1.0e-9; % $ to T$ %%%%% Cost per a quarantined
CpD = VSL *1.0e-9; % $ to T$ %%%%% Cost per a death
DecrementGDP = perGDP/365 * ReducedGDP *1.0e-9; % $ to T$ %%%%% GDP decrement per a person per a day

CpI = CpQ +f*CpD; % B$ %%%%% Cost per an infection
CpNPI = DecrementGDP/(meanmean(MCMC_Results(1:end-2))); % T$ %%%%% Cost per a mean NPIs per a person per a day

CPlot.CNPI = CpNPI * MultiObjResult.fval(:,1).*MultiObjResult.fval(:,3)*(SimulLength+14);
CPlot.NumI = MultiObjResult.fval(:,2);
CPlot.CI = CpI * 10.^(CPlot.NumI); % Total infection cost B $
CPlot.CIvec = 10.^(-6:0.001:-2);
CPlot.DataX = DataMultiObj(1);
CPlot.DataY = CpI*10.^(DataMultiObj(2)) + CpNPI*DataMultiObj(1)*DataMultiObj(3)*(SimulLength+14);
%Cplot.Scenario
%%
nexttile(1)

hold on
ar = area(MultiObjResult.fval(:,1),[CPlot.CNPI,CPlot.CI]);
ar(1).FaceColor = Tea;
ar(2).FaceColor = Ora;

plot(MultiObjResult.fval(:,1),sum([CPlot.CNPI,CPlot.CI],2),'-','LineWidth',2.5,'Color',[0.4,0.4,0.4])
%ar(2).EdgeColor = [0.4,0.4,0.4];
%ar(2).LineWidth = 2.5;

plot(-1,-1,'gs','MarkerSize',5,'MarkerFaceColor','g')
plot(-1,-1,'rd','MarkerSize',7,'MarkerFaceColor','r','LineStyle','-','LineWidth',1,'Color','k')

[OptCostVal,OptCostIdx] = min(sum([CPlot.CNPI,CPlot.CI],2));
for i=[1:5]
    plot(MultiObjResult.fval(idxx(i),1),sum([CPlot.CNPI(idxx(i)),CPlot.CI(idxx(i))]),'o','MarkerSize',7,'MarkerFaceColor',FigInfo.MultiObjColor(i,:),'MarkerEdgeColor','none');
end
plot(MultiObjResult.fval(OptCostIdx,1),OptCostVal,'gs','MarkerSize',5,'MarkerFaceColor','g')
plot(CPlot.DataX,CPlot.DataY,'rd','MarkerSize',7,'MarkerFaceColor','r','LineStyle','-','LineWidth',1,'Color','k')
xlim([min(MultiObjResult.fval(:,1)),max(MultiObjResult.fval(:,1))])
ylim([1,2500])
xlabel('$f_1(\mu(t))$','Interpreter','latex')
ylabel('Cost (US $)')
set(gca,'TickLabelInterpreter','tex','TickDir','Out',...
    'XTick',[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8],'XTickLabel',{'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8'},...
    'YTick',[1.0e+0,1.0e+1,1.0e+2,1.0e+3],'YTickLabel',{'1B';'10B';'100B';'1T'},...
    'YScale','log',...
    'FontSize',12,'FontName','Times')
%title('Total cost for each strategy','Interpreter','tex','FontWeight','bold','FontSize',14)
lg = legend("Cost of NPIs","Cost of infections","Total cost",'FontSize',10,'Location','best');
title(lg,'Cost for Pareto curve','FontWeight','normal')
clear ar; clear lg
% plot(MultiObjResult.fval(:,1),10.^MultiObjResult.fval(:,2)/Info.Data.Pop,'k-','LineWidth',1.5);
% DataMultiObj = obj(MCMC_Results);
% plot(DataMultiObj(1),10.^DataMultiObj(2)/Info.Data.Pop,'rd','MarkerSize',7,'MarkerFaceColor','r','MarkerEdgeColor','none')
% for i=1:8
%     plot(MultiObjResult.fval(idx(i),1),10.^MultiObjResult.fval(idx(i),2)/Info.Data.Pop,'o','MarkerSize',7,'MarkerFaceColor',FigInfo.MultiObjColor(i,:),'MarkerEdgeColor','none');
% end
%%
idx = []; 
for i = 1:8
    [~,idx(i)] = min(abs(MultiObjResult.fval(:,1)-i/10));
end
MultiObjEx = [zeros(5,2),MultiObjResult.x(idxx,:)];
%%

nexttile(2)
hold on
% CPlot.CNPI = CpNPI * MultiObjResult.fval(:,1).*MultiObjResult.fval(:,3)*154;
% CPlot.CI = CpI * 10.^(CPlot.NumI); % Total infection cost B $
[Surf1X,Surf1Y] = meshgrid(MultiObjResult.fval(:,1),CPlot.CIvec);
Surf1Z = log10(CpNPI*Surf1X.*MultiObjResult.fval(:,3)'*(SimulLength+14) + Surf1Y.*10.^(CPlot.NumI'));
surf(Surf1X,Surf1Y,Surf1Z,'EdgeColor','none')

OptimPoints = zeros(length(CPlot.CIvec),4);
OptimPoints(:,2) = CPlot.CIvec;

for i=1:length(CPlot.CIvec)
    [OptimPoints(i,3),OptimPoints(i,4)] = min(Surf1Z(i,:));
    OptimPoints(i,1) = MultiObjResult.fval(OptimPoints(i,4),1);
end

[OptimIndexX,OptimIndexY,~] = unique(OptimPoints(:,4));
BigChangeIndex = [1,find((sum(abs(diff(MultiObjResult.x(OptimIndexX,:))),2)>1))'+1,length(OptimIndexX)];
%BigChangeIndex(find(diff(BigChangeIndex)==1)+1)=[];

%plot3(OptimPoints(:,1),OptimPoints(:,2),OptimPoints(:,3),'-','LineWidth',1,'Color',[0,0.5,0])
plot3(MultiObjResult.fval(:,1),4.6800e-05+0*MultiObjResult.fval(:,1),6+0*MultiObjResult.fval(:,1),'-','LineWidth',2.5,'Color',[0.4,0.4,0.4])

%plot3(-10,-10,-1,'o','MarkerSize',3,'MarkerFaceColor','g','MarkerEdgeColor','none')
%plot3(-10,-10,-1,'o','MarkerSize',7,'MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor','none')

%plot3(-10,-10,-1,'o','MarkerSize',7,'MarkerFaceColor','none','MarkerEdgeColor','k','LineWidth',1)



% PlotCount = 0;
% for i=1:length(OptimIndexX)
%     if sum(i == BigChangeIndex)
%         if i==BigChangeIndex(end)
%         else
%         PlotCount = PlotCount+1;
%         plot3(MultiObjResult.fval(OptimIndexX(i),1),CPlot.CIvec(OptimIndexY(i)),4*ones(1,length(OptimIndexY(i))),'o','MarkerSize',8,'MarkerFaceColor',FigInfo.CostOptimalColor(mod(PlotCount,4)+1,:),'MarkerEdgeColor','k','LineWIdth',1)
%         end
%     end
% end






for i=1:length(OptimPoints(:,4))
    plot3(MultiObjResult.fval(OptimPoints(i,4),1),CPlot.CIvec(i),6*ones(1,length(i)),'s','MarkerSize',3,'MarkerFaceColor','g','MarkerEdgeColor','none')
end


%plot3(-10,-10,-1,'o','MarkerSize',7,'MarkerFaceColor','none','MarkerEdgeColor','k','LineWidth',1.5)
%plot3(OptimPoints(:,1),OptimPoints(:,2),OptimPoints(:,3)+2,'g-','LineWidth',1.5)



xlim([min(MultiObjResult.fval(:,1)),max(MultiObjResult.fval(:,1))])
ylim([min(CPlot.CIvec),max(CPlot.CIvec)])
zlim([0.1,6])

xlabel('$f_1(\mu(t))$','Interpreter','latex')
ylabel({"Cost per infection (US $)"},'FontName','Times')

colormap(gca,'turbo')
%clim([1,6])
cb = colorbar;
cb.Ticks = [1,2,3,4,5];
cb.TickLabels = {"1B","10B","100B","1T","10T"};
cb.FontSize = 12;
cb.Limits = [1,5];
clear cb
clear Surf1X; clear Surf1Y; clear Surf1Z
%cb.Label.String = 'Elevation (ft in 1000s)';
%legend("","Optimal Curve","Cost optimal solution","",'Location','southeast')



%xlabel({'Time point from the first confirmed case';'  '})

set(gca,'YScale','log','TickDir','Out',...
    'XTick',[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8],'XTickLabel',{'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8'},...
    'YTick',[1.0e-6,1.0e-5,1.0e-4,1.0e-3,1.0e-2],'YTickLabel',{"1K","10K","100K","1M","10M"},...
    'ZTick',[1,2,3,4,5],'ZTickLabel',{'10','100','10^3','10^4','10^5'},...
    'FontSize',12,'FontName','Times')
%title('Total cost for Pareto curve','FontWeight','bold','FontSize',14)
legend("","Cost per infection (Korea)","Cost-optimal solutions",'Location','southeast','FontSize',10);
%title(lgd,{"Cost-optimal strategy";"for cost per infection"},'FontWeight','normal')


%%

Filename_MultiObj = ['Results/Figures/MultiObj/Figure4b_',char(CountryName),'.png'];
exportgraphics(figure(5),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4b_',char(CountryName),'.eps'];
exportgraphics(figure(5),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4b_',char(CountryName),'.pdf'];
exportgraphics(figure(5),Filename_MultiObj,'Resolution',600)
Filename_MultiObj = ['Results/Figures/MultiObj/Figure4b_',char(CountryName),'.jpg'];
exportgraphics(figure(5),Filename_MultiObj,'Resolution',600)


%title('NPIs (\mu(t)) strategy','FontWeight','bold','FontSize',14)
% Save figure
%exportgraphics(figure(7),'Figures/Figure07_CostOptimalSol2.png','Resolution',600)