function ss = OBJ_fit(x,DataCase,...
    DataTime,FittingTime,X0,FittingDividingPoint,...
    beta,kappa,alpha,gamma,f)

[~,X] = ode45(@ODE_fit,FittingTime,[X0,0,0,0],[],x,FittingDividingPoint,beta,kappa,alpha,gamma,f);
%ObjModel = X(:,end);

ss = sqrt(sum( (DataCase-X(DataTime-FittingTime(1),end)).^2 ));%...
     %+sqrt(sum( ([DataCase(1);diff(DataCase)]-[X(DataTime(1)-FittingTime(1),end);diff(X(DataTime-FittingTime(1),end))]).^2 ))*mean(DataCase)/mean(diff(DataCase));

%% Note
%DailyData = [ObjData(1);diff(ObjData)];
%DailyModel = [ObjModel(1);diff(ObjModel)];
%NormalizeFactor = (mean(ObjData)/mean(DailyData))^2;

% figure
% hold on
% plot(DataTime,DataCase,'ro')
% plot(DataTime,X(DataTime-FittingTime(1),end),'k-')

% figure
% hold on 
% plot(DataTime,[DataCase(1);diff(DataCase)],'ro')
% plot(DataTime,[X(DataTime(1)-FittingTime(1),end);diff(X(DataTime-FittingTime(1),end))],'k-')