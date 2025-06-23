index = 0;
for i=1:length(MultiObjResult.fval(:,2))-1
    if MultiObjResult.fval(i-index,1) >= MultiObjResult.fval(i+1-index,1)
        Index = MultiObjResult.fval(i+1-index,1) <= MultiObjResult.fval(1:i-index,1);
        MultiObjResult.fval(find(Index),:) = []; MultiObjResult.x(find(Index),:) = [];
        index = index +sum(Index);
    end
end


% MultiObjResult.fval(i-index,:)=[]; MultiObjResult.x(i-index,:)=[];