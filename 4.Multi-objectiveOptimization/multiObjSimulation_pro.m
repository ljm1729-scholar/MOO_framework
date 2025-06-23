function [MultiObjResult,index]  = multiObjSimulation_pro(SimNum,obj,NumOfMu,lb,ub,GAoptions)
% Initialize
MultiObjResult.x = []; MultiObjResult.fval = [];

for i=1:SimNum
    [TempResult.x,TempResult.fval,~,~,~,~]=gamultiobj(obj,NumOfMu,[],[],[],[],lb,ub,[],GAoptions);
    MultiObjResult.x=[MultiObjResult.x;TempResult.x];
    MultiObjResult.fval=[MultiObjResult.fval;TempResult.fval]; 
end
[~,index]=sort(MultiObjResult.fval(:,2),'descend');
MultiObjResult.x=MultiObjResult.x(index,:);
MultiObjResult.fval=MultiObjResult.fval(index,:);

CheckParetoOptimality

