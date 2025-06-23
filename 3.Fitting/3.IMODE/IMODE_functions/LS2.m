%% ============EBOwithCMAR ============
% Should you have any queries, please contact
% Mr.Abhishek Kumar
% emailid: abhishek.kumar.eee13@iitbhu.ac.in
% =========================================================================
function [x,f,current_eval,succ] = LS2 (func,bestx,f,Par,current_eval,Max_FES,xmin,xmax)
Par.LS_FE=min(ceil(20.0000e-003*Max_FES ),(Max_FES-current_eval));
%Par.LS_FE=ceil(20.0000e-003*Max_FES ); %% Max FFEs_LS
% Par.LS_FE = 20*Par.n;
options=optimset('Display','off','algorithm','interior-point',...
    'UseParallel','never','MaxFunEvals',Par.LS_FE) ;

[Xsqp, FUN , ~ , details]=fmincon(func, bestx(1,:),[],[],[],[],xmin,xmax, [],options);

%% check if there is an improvement in the fitness value and update P_{ls}
if (f-FUN)>0
    succ=1;
    f = FUN;
    x(1,:)=Xsqp;
else
    succ=0;
    x=bestx;
   
end
%% update FFEs
current_eval=current_eval+details.funcCount;
% details.funcCount
end


