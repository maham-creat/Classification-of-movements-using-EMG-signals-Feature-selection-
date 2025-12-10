clear; clc;

% Load data
load('sbestfeatallsubj.mat')

%emgs1 = real(table2array(f));
emgs1 =(f);
X = emgs1(:, 1:end-1);
Y = emgs1(:, end);
time=[];oa=[];

numFolds = 5;
for i=1:5
tic
accuracy_ann = [];
all_actual = [];
all_predicted_ann = [];

% Define hyperparameters for ANN


% Perform 5-fold cross-validation
cv = cvpartition(size(X, 1), 'KFold', numFolds);
for fold = 1:numFolds
    trainIdx = training(cv, fold);
    testIdx = test(cv, fold);
    X_train = X(trainIdx, :);
    Y_train = Y(trainIdx, :);
    X_test = X(testIdx, :);
    Y_test = Y(testIdx, :);
    
    % Create and train the ANN
    classifier = fitcnet(X_train, Y_train,'LayerSizes', 100, 'Activations', 'relu', 'Lambda', 0,'IterationLimit', 1000, 'Standardize',true);
   % Test the ANN  
  
    Y_pred_ann = predict(classifier, X_test);
    
    % Calculate accuracy
    accuracy_ann(fold) = sum(Y_pred_ann == Y_test) / numel(Y_test);
    
    % Store actual and predicted labels for this fold
    all_actual = [all_actual; Y_test];
    all_predicted_ann = [all_predicted_ann; Y_pred_ann];
end

% Calculate overall accuracy for all folds
overall_accuracy_ann = sum(all_predicted_ann == all_actual) / numel(all_actual);
oa=[oa overall_accuracy_ann]
% Display overall accuracy
disp(['Overall ANN Accuracy: ', num2str(overall_accuracy_ann * 100), '%']);
t=toc
time=[time t]
end
ac=oa*100