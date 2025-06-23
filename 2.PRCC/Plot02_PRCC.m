PlotPRCC.TimeIdx = 1:length(time_points);
PlotPRCC.alpha = something;
PlotPRCC.PRCC_var = PRCC_var;

s = PlotPRCC.TimeIdx;
aalpha = PlotPRCC.alpha;
PRCCs1 = PlotPRCC.prcc1;
PRCCs2 = PlotPRCC.prcc2;

%% Figure: Appendix D
len_PRCC = length(abs(PRCCs1(:,1)));
XTickLabel_PRCC = [" "]; XTickLabel_PRCC(len_PRCC) = [" "]; 
for i=1:len_PRCC
    XTickLabel_PRCC(i) = [num2str((i-2)*2),'w'];
end
XTickLabel_PRCC(2) = ["Idx"];

FigPRCC1 = figure(505);
set(gcf,"Name","PRCC_Sensitivity analysis",'Units','centimeters','Position',[0,0,25,16])
tiledlayout(2,1,'padding','compact','TileSpacing','Compact')

%% Tile 1: Cumulative infected cases
nexttile(1)
hold on

plot(1:len_PRCC,abs(PRCCs1(:,1)),'-','Color','#003a7d','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,2)),'-','Color','#008dff','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,3)),'-','Color','#c701ff','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,4)),'--','Color','#d83034','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,5)),'--','Color','#ff9d3a','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,6)),'-','Color','#ff73b6','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,7)),'-','Color','#ff73b6','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs1(:,8)),'-','Color','#ff73b6','LineWidth',2)
ylabel({'PRCC value';'for cumulative infected cases'})
xlabel('Time point from the index case')
xlim([1,len_PRCC])
ylim([0,1])
legend(PRCC_var,'Location','eastoutside')
set(gca,...
    'XTick',1:2:len_PRCC,'XTickLabel',XTickLabel_PRCC,...
    'FontName','Times')
%% Tile 2: Cumulative confirmed cases

nexttile(2)
hold on
plot(1:len_PRCC,abs(PRCCs2(:,1)),'-','Color','#003a7d','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,2)),'-','Color','#008dff','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,3)),'-','Color','#c701ff','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,4)),'--','Color','#d83034','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,5)),'--','Color','#ff9d3a','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,6)),'-','Color','#ff73b6','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,7)),'-','Color','#ff73b6','LineWidth',2)
plot(1:len_PRCC,abs(PRCCs2(:,8)),'-','Color','#ff73b6','LineWidth',2)
ylabel({'PRCC value';'for cumulative confirmed cases'})
xlabel('Time point from the index case')
xlim([1,len_PRCC])
ylim([0,1])
legend(PRCC_var,'Location','eastoutside')
set(gca,...
    'XTick',1:2:len_PRCC,'XTickLabel',XTickLabel_PRCC,...
    'FontName','Times')

%% Save the figure

Filename_PRCC = ['Results/Figures/PRCC/Figure2_',char(CountryName),'.png'];
exportgraphics(figure(505),Filename_PRCC,'Resolution',600)
Filename_PRCC = ['Results/Figures/PRCC/Figure2_',char(CountryName),'.eps'];
exportgraphics(figure(505),Filename_PRCC,'Resolution',600)
Filename_PRCC = ['Results/Figures/PRCC/Figure2_',char(CountryName),'.pdf'];
exportgraphics(figure(505),Filename_PRCC,'Resolution',600)
Filename_PRCC = ['Results/Figures/PRCC/Figure2_',char(CountryName),'.jpg'];
exportgraphics(figure(505),Filename_PRCC,'Resolution',600)

%% Record time 
% Time record 2: PRCC
timestone = RecordTime("PRCC",timestone);