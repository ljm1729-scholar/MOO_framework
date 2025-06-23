figure(501)
set(gcf,"Name","[IMODE] Fitting result, setting the initial valule for bayesian inference",'Units','Centimeter','Position',[0,0,25,14])
clf
tiledlayout(4,8,'Padding','compact','TileSpacing','compact')

nexttile(1,[2,8])

[~,X_IMODEfit] = ode45(@ODE_fit,FittingTime,[X0,0,0,0],[],IMODE_Results,FittingDividingPoint,Re0,kappa,alpha,gamma,f);


% plot(DataCountires{i}.ydata(:,1),[DataCountires{i}.ydata(1,2);diff(DataCountires{i}.ydata(:,2))])
% plot(DataCountires{i}.ydata(:,1),alpha*ODE_result{i}(:,3))
% title(NameList(i))
hold on
plot(DataTime,DataCase,'ro','MarkerSize',5)
plot(FittingTime,X_IMODEfit(:,end),'k-','LineWidth',1)
ylabel("Cumulative confirmed cases")
xlim([FittingTime(1),FittingTime(end)])
XTick = FittingDividingPoint; XTickLabel = datestr(XTick,'dd mmm, yyyy');
set(gca,'XTick',XTick,'XTickLabel',XTickLabel)


nexttile(17,[2,7])
hold on

[~,MinIndexIMODE] = min(IMODE_search(:,1));
EvalX = 'paramLabel = {';
for i=1:length(IMODE_search(:,2:end))
    EvalX = [EvalX,'"',num2str(i),'"'];
    if i~=length(IMODE_search(:,2:end))
        EvalX = [EvalX,','];
    end
end
EvalX = [EvalX,'};']; eval(EvalX)
boxplot(IMODE_search(:,2:end),paramLabel)
hold on
plot(linspace(min(gca().XTick),max(gca().XTick),length(IMODE_search(MinIndexIMODE,2:end))),IMODE_search(MinIndexIMODE,2:end),'ro','MarkerSize',5,'MarkerFaceColor','r')


nexttile(24,[2,1])
hold on
boxplot(IMODE_search(:,1))
ylabel("Objectives")

%% Save figure
Filename_IMODE = ['Results/Figures/IMODE/FigureS2_',char(CountryName),'.png'];
exportgraphics(figure(501),Filename_IMODE,'Resolution',600)
Filename_IMODE = ['Results/Figures/IMODE/FigureS2_',char(CountryName),'.eps'];
exportgraphics(figure(501),Filename_IMODE,'Resolution',600)
Filename_IMODE = ['Results/Figures/IMODE/FigureS2_',char(CountryName),'.pdf'];
exportgraphics(figure(501),Filename_IMODE,'Resolution',600)
Filename_IMODE = ['Results/Figures/IMODE/FigureS2_',char(CountryName),'.jpg'];
exportgraphics(figure(501),Filename_IMODE,'Resolution',600)

%% Record time 
% Time record 3: IMODE - making prior distribution of MCMC process
timestone = RecordTime("IMODE",timestone);