figure(4)
clf
set(gcf,"Name","Multi-objective optimization results",'Units','centimeters','Position',[0,0,25,10])
tiledlayout(18,5,'Padding','tight','TileSpacing','compact');

idx = [];
for i = 1:8
    [~,idx(i)] = min(abs(MultiObjResult.fval(:,1)-i/10));
end
MultiObjEx = [zeros(8,2),MultiObjResult.x(idx,:)];

nexttile(1,[9,2])

hold on
plot(MultiObjResult.fval(:,1),10.^MultiObjResult.fval(:,2)/Info.Data.Pop,'k-','LineWidth',1.5);
DataMultiObj = obj(IMODE_Results(1:end-2));
plot(DataMultiObj(1),10.^DataMultiObj(2)/Info.Data.Pop,'rd','MarkerSize',7,'MarkerFaceColor','r','LineWidth',1,'MarkerEdgeColor','k')
plot(-1,-1,'o','MarkerSize',8,'MarkerFaceColor','none','MarkerEdgeColor','k','LineWidth',1);

% for i=1:8
%     plot(MultiObjResult.fval(idx(i),1),10.^MultiObjResult.fval(idx(i),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(i,:),'MarkerEdgeColor','k','LineWIdth',1);
% end

p1 = plot(MultiObjResult.fval(idx(1),1),10.^MultiObjResult.fval(idx(1),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(1,:),'MarkerEdgeColor','k','LineWIdth',1);
p2 = plot(MultiObjResult.fval(idx(2),1),10.^MultiObjResult.fval(idx(2),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(2,:),'MarkerEdgeColor','k','LineWIdth',1);
p3 = plot(MultiObjResult.fval(idx(3),1),10.^MultiObjResult.fval(idx(3),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(3,:),'MarkerEdgeColor','k','LineWIdth',1);
p4 = plot(MultiObjResult.fval(idx(4),1),10.^MultiObjResult.fval(idx(4),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(4,:),'MarkerEdgeColor','k','LineWIdth',1);
p5 = plot(MultiObjResult.fval(idx(5),1),10.^MultiObjResult.fval(idx(5),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(5,:),'MarkerEdgeColor','k','LineWIdth',1);
p6 = plot(MultiObjResult.fval(idx(6),1),10.^MultiObjResult.fval(idx(6),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(6,:),'MarkerEdgeColor','k','LineWIdth',1);
p7 = plot(MultiObjResult.fval(idx(7),1),10.^MultiObjResult.fval(idx(7),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(7,:),'MarkerEdgeColor','k','LineWIdth',1);
p8 = plot(MultiObjResult.fval(idx(8),1),10.^MultiObjResult.fval(idx(8),2)/Info.Data.Pop,'o','MarkerSize',8,'MarkerFaceColor',FigInfo.MultiObjColor(8,:),'MarkerEdgeColor','k','LineWIdth',1);

%title('Pareto optimal set');

xlim([min(MultiObjResult.fval(:,1)),max(MultiObjResult.fval(:,1))])
xlabel('$\bar{\mu}$','Interpreter','latex')
ylim([1.0e-6,1])
ylabel({'Proportion of confirmed cases';'(per a million)'})


set(gca,'TickLabelInterpreter','tex',...
    'XTick',[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8],'XTickLabel',{'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8'},...
    'YTick',[1.0e-6,1.0e-5,1.0e-4,1.0e-3,1.0e-2,1.0e-1,1.0e-0],'YTickLabel',{'10^{-6}';'10^{-5}';'10^{-4}';'10^{-3}';'10^{-2}';'10^{-1}';'1'},...
    'YScale','log',...
    'FontSize',12,'FontName','Times','TickDir','out')

title('Objective space','Interpreter','tex','FontSize',14,'FontWeight','bold')
legend("Pareto curve","Estimated NPIs strategy",'FontSize',10,'Location','southwest'); %,'Pareto optimal NPIs strategy'
%ah1=axes('position',get(gca,'position'),'visible','off');
%lgd2 = legend(ah1,[p1,p2,p3,p4,p5,p6,p7,p8],'PoS 1','PoS 2','PoS 3','PoS 4','PoS 5','PoS 6','PoS 7','PoS 8');
%set(gca,'FontSize',10,'FontName','Times')

for i=1:4
    nexttile(5*i -2,[1,3])
    hold on
    plot(1:12,MultiObjEx(i,:),'LineWidth',2,'Color',FigInfo.MultiObjColor(i,:))
    xlim([1 12])
    ylim([0,1])
    set(gca,'TickLabelInterpreter','tex',...
    'YTick',[0,1],'YTickLabel',[],...
    'XTick',1:12,'XTickLabel',[],...
    'FontSize',8,'FontName','Times','YGrid','on')
end
nexttile(23,[1,3])
hold on
plot(1:12,[0,0,IMODE_Results(1:end-2)],'LineWidth',2,'Color','r')
xlim([1 12])
ylim([0,1])
set(gca,'TickLabelInterpreter','tex',...
'YTick',[0,1],'YTickLabel',["0","1"],...
'XTick',1:12,'XTickLabel',[],...
'FontSize',4,'FontName','Times','YGrid','on')

for i=5:8
    nexttile(5*i +3,[1,3])
    plot(1:12,MultiObjEx(i,:),'LineWidth',2,'Color',FigInfo.MultiObjColor(i,:))
    xlim([1 12])
    ylim([0,1])
    set(gca,'TickLabelInterpreter','tex',...
    'YTick',[0,1],'YTickLabel',[],...
    'XTick',1:12,'XTickLabel',[],...
    'FontSize',8,'FontName','Times','YGrid','on')
end
xlabel({'Time point from the index case';'  '})
set(gca,'TickLabelInterpreter','tex',...
    'YTick',0:1,'YTickLabel',[],...
    'XTick',1:12,'XTickLabel',["-2nd week","Index case","2nd week","4th week","6th week","8th week","10th week","12th week","14th week","16th week","18th week","20th week"],...
    'FontSize',12,'FontName','Times','YGrid','on')
nexttile(3,[1,3])
title('NPIs (\mu(t)) strategy','FontSize',12,'FontName','times','FontWeight','bold')

% xlim([1 12])
% ylim([0,9])
% ylabel('Scenario')
% xlabel({'Time point from the index case';'  '})
% set(gca,'TickLabelInterpreter','tex',...
%     'YTick',0:8,'YTickLabel',["S1","S2","S3","S4","S5","SE","S6","S7","S8"],...
%     'XTick',1:12,'XTickLabel',["-2nd week","1st week","3rd week","5th week","7th week","9th week","11th week","13th week","15th week","17th week","19th week","21th week"],...
%     'FontSize',12,'FontName','Times','YGrid','on')
% title('\mu(t) for each strategy','Interpreter','tex','FontSize',14,'FontWeight','bold')

% Save figure
exportgraphics(figure(4),'Figures/Figure04_MultiObj.png','Resolution',600)
