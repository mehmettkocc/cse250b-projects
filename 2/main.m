% LOAD EXAMPLES IN WORKSPACE
%{
put code here according to the description

read the dataset here and load all training examples in X and their labels 
in Y. similarly, all test examples in Xtest and their labels in Ytest. Keep
X, Y, Xtest and Ytest in the workspace.

X = [x1; x2; ..., xn] and Y = [y1; y2;..., yn] 
where n=allTrainingSetSize and Xtest and Ytest has the same structure

According to the files, there are 70115 all training examples and 28027 
test examples. So, the each of 70115 rows in X and Y belong to one training
example.
%}

ySet = {'COMMA', 'PERIOD' , 'QUESTION_MARK', 'EXCLAMATION_POINT', 'COLON', 'SPACE'};
% split into validation and actual training sets
allTrainingSize = size(X, 1);
testSize = size(Xtest, 1);
% put the length of features here
featSize = 100;
% the [0, 1] percentage of validation set in all training set
valRatio = 0.3;

%split all training set into actual training set and validation set
valIndLogical = splitTrainingSet(allTrainingSize, valRatio);
tempInd = (1:allTrainingSize);
valInd = tempInd(valIndLogical);
trainingInd = tempInd(~valIndLogical);
valSize = length(valInd);
trainingSize = exSize - valSize;
%%
% perceptron training
% regularization parameter
muVal = 5.^(0:0);
% learning parameter and its exponential decay at each epoch
lambda0Val = 10.^(-1:-1); decayRate = 0.8;
% number of epochs used for training
epochNum = 5;

% store grid-search results in these variables
bestW = zeros(length(muVal), length(lambda0Val), featSize);
avgLCL = zeros(length(muVal), length(lambda0Val));

trainingFeatures = getFeatures(trainingInd, 1);
% grid search 
for i=1:length(muVal)
    mu = muVal(i);
    for j=1:length(lambda0Val)
        lambda0 = lambda0Val(j);
        % reset w for each new hyperparameter pair (mu, lambda)
        w = zeros(featSize, 1);
        % obtain optimal w with the current parameters
        for k=1:epochNum
            lambda = lambda0 * decayRate^(k-1);
            for l=1:trainingSize
                G = getScoreMatrix(trainingInd(l), w, 1);
                [currBestSeq, ~] = getBestLabelSequence(G);                 
                expectedFeatures = getFeatures2(trainingInd(l), currBestSeq, 1);
                % gradient ascent update
                w = w + lambda * (trainingFeatures(:, l)-expectedFeatures-2*mu*w);
            end
        end
        bestW(i, j, :) = w;
        avgLCL(i, j) = getLCL(valInd, w, logZ, 1);
    end    
end



