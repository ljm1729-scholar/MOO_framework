close all

figure(123456)
clf
tiledlayout(1,3,"TileSpacing","compact","Padding","compact") 
t=linspace(0,1,10001); 
a=2;
LW=1.5;
%% exponential
f1=@(t) (exp(a*t)-1)/(exp(a)-1);
f2=@(t) log( ( (exp(a)-1)*t+1 ).^(1/a) );
nexttile(1)
hold on
plot(t,t,'k-','LineWidth',LW)
plot(t,f1(t),'r-','LineWidth',LW)
xlabel('NPI strength')
ylabel('Relative cost')
title('$h:s\to c$','Interpreter','latex')
set(gca,'FontName','Times')
pause(0.01)

nexttile(2)
hold on
plot(t,t,'k-','LineWidth',LW)
plot(t,f2(t),'r-','LineWidth',LW)
xlabel('NPI strength')
ylabel('Effectiveness')
title('$g:s\to \mu$','Interpreter','latex')
set(gca,'FontName','Times')
pause(0.01)

nexttile(3)
hold on
plot(t,t,'k-','LineWidth',LW)
plot(t,f1(f1(t)),'r-','LineWidth',LW)
xlabel('Effectiveness')
ylabel('Relative cost')
title('$h\circ g^{-1}:\mu\to c$','Interpreter','latex')
set(gca,'FontName','Times')
pause(0.01)

%% polynomial 1
f1=@(t) t.^a;
f2=@(t) t.^(1/a);
nexttile(1)
hold on
plot(t,f1(t),'b-','LineWidth',LW)
pause(0.01)

nexttile(2)
hold on
plot(t,f2(t),'b-','LineWidth',LW)
pause(0.01)

nexttile(3)
hold on
plot(t,f1(f1(t)),'b-','LineWidth',LW)
pause(0.01)

%% polynomial 2
f1=@(t) 1-((1-t).^(1/a));
f2=@(t) 1-((1-t).^a);
nexttile(1)
hold on
plot(t,f1(t),'g-','LineWidth',LW)
xlabel('NPI strength')
ylabel('Relative cost')
legend('$c=s$','$c=(e^{2s}-1)/(e^2-1)$','$c=s^2$','$c=1-(1-s)^{1/2}$','Interpreter','latex','Location','northwest')
pause(0.01)

nexttile(2)
hold on
plot(t,f2(t),'g-','LineWidth',LW)
xlabel('NPI strength')
ylabel('Effectiveness')
legend('$\mu=s$','$\mu=\ln((e^a-1)s+1)^{1/a}$','$\mu=s^{1/2}$','$\mu=1-(1-s)^{2}$','Interpreter','latex','Location','southeast')
pause(0.01)

nexttile(3)
hold on
plot(t,f1(f1(t)),'g-','LineWidth',LW)
xlabel('Effectiveness')
ylabel('Relative cost')
%legend('$log((e^a-1)s+1)^{1/a}$','$s^{4}$','$1-(1-s)^{1/4}$','Interpreter','latex','Location','northwest')
pause(0.01)
%%
figure(123457)
clf
tiledlayout(1,1,'TileSpacing','compact','Padding','compact')
nexttile(1)
t=linspace(0,1,10001); 
f1=@(t,a) t.^a;
hold on
a = [1,sqrt(2),2];LW=1.5;
plot(t,f1(t,a(1)),'r-','LineWidth',LW)
plot(t,f1(t,a(2)),'g-','LineWidth',LW)
plot(t,f1(t,a(3)),'b-','LineWidth',LW)

xlabel('Average transmission reduction')
ylabel('Relative cost')
set(gca,'FontName','Times','FontSize',12)
legend('$x$','$x^{\sqrt{2}}$','$x^2$','Interpreter','latex','Location','northwest')

nexttile(2)
f2 = @(t,b) (1-x)*x

