%{
Author: Mehmet Koc
Date: 1/18/14
Description: Computes the statistics for all features and then
plots them: MIN, MAX, MEAN, STD, SPARSITY(in the range [0, 1]),
DISTINCT_VALUES (number of distinct values each feature gets)
%}
function [] = getFeatureStats(featureMatrix)
featNum = size(featureMatrix, 2);
exNum = size(featureMatrix, 1);
%MIN
figure, 
subplot(2, 3, 1), plot(1:featNum, min(featureMatrix)); 
xlim([0, featNum+1]);
title(['(a)ExNo: ', num2str(exNum), '. The min for all features']);
%MAX
subplot(2, 3, 2), plot(1:featNum, max(featureMatrix));
xlim([0, featNum+1]);
title('(b)The max statistics for all features');
%MEAN
subplot(2, 3, 3), plot(1:featNum, mean(featureMatrix));
xlim([0, featNum+1]);
title('(c)The mean statistics for all features');
%STD
subplot(2, 3, 4), plot(1:featNum, std(featureMatrix));
xlim([0, featNum+1]);
title('(d)The std statistics for all features');
%SPARSITY
subplot(2, 3, 5), plot(1:featNum, sum(featureMatrix==0)/exNum);
xlim([0, featNum+1]);
title('(e)The sparsity for all features');
%DISTINCT VALUE NUMBER
distinctValNum = zeros(1, featNum);
for i=1:featNum
    distinctValNum(i) = length(unique(featureMatrix(:, i)));
end
subplot(2, 3, 6), plot(1:featNum, distinctValNum);
xlim([0, featNum+1]);
title('(f)The number of distinct values for all features');

end