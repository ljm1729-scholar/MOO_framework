function result = meanmean(x)
x=[0,0,x];
lengthlength = length(x);
result = zeros(lengthlength-1,1);
for i=1:lengthlength-1
    result(i)=mean(x(i:i+1));
end
result = mean(result);