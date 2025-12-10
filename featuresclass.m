
ac1=[]
 for i=1:39
variable_name = ['f', num2str(i)];
    
    % Access the variable
    f= eval(variable_name);
data=table2array(f);
    % Cross validation (train: 70%, test: 30%)
    cv = cvpartition(size(data,1),'kfold',5);
   

      for j = 1:5
        trainInds = training(cv, j);
        testInds = test(cv, j);
        trainingData = data(trainInds, :);
        testData = data(testInds, :);
        % Train a classifier using the training data
        mdl = fitcnet(trainingData(:, 1:end-1), trainingData(:, end), 'LayerSizes', [120 50], 'Activations', 'relu', 'Lambda', 0, 'IterationLimit', 2000, 'Standardize', true);
        % Predict labels for the test data
        predicted_labels = predict(mdl, testData(:, 1:end-1));
        testing_labels = testData(:, end);
        % Compute the accuracy of the classifier
        accuracy = mean(predicted_labels == testing_labels);
         accuracy=accuracy'
        % Compute the confusion matrix of the classifier
        % confusion_matrix = confusionmat(testing_labels, predicted_labels);
        % % Display the per-class accuracy
        % per_class_accuracy = diag(confusion_matrix) ./ sum(confusion_matrix, 2);
        % % fprintf('Per-class accuracy for fold %d: %s\n', j, strjoin(string(per_class_accuracy), ', '));
          end
    % per_class_accuracy_table = [  per_class_accuracy_table
    % per_class_accuracy];
          accuracy = mean(accuracy);
  ac1=[ac1;accuracy];
 end
