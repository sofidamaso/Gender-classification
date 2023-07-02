clear;
[images, labels]= readlists();
nimages = numel(images);
lbp =[];
 for n = 1 : nimages
    im = imread(['gender-feret-master-union/gender-feret-master/' images{n}]);
    lbp = [lbp;compute_lbp(im)];
 end

% Partizionamento dei dati
% prima partizione 20% e 80%
cv1 = cvpartition(labels,'Holdout',0.2);
cv1_trainLabels = labels(cv1.training);
cv1_trainValues = lbp(cv1.training,:);
cv1_testLabels = labels(cv1.test);
cv1_testValues = lbp(cv1.test,:);

%seconda partizione 20% e 80%
cv2 = cvpartition(cv1_trainLabels,'Holdout',0.2);              
cv2_trainLabels = cv1_trainLabels(cv2.training);
cv2_trainValues = cv1_trainValues(cv2.training,:);
cv2_validationLabels = cv1_trainLabels(cv2.test);
cv2_validationValues = cv1_trainValues(cv2.test,:);

% stima del K migliore
accuracy_result_eu= [];
validation_eu= [];
accuracy_result_cb= [];
validation_cb= [];

% distanza euclidea
for k=1:2:20
    [train_result, validation_result,~] = knn(cv2_trainValues,cv2_trainLabels,cv2_validationValues,cv2_validationLabels,k,'euclidean');
    validation_eu= [validation_eu; validation_result];
    accuracy_result_eu= [accuracy_result_eu; validation_result.accuracy, k];
end
accuracy_eu= max(accuracy_result_eu(:,1));
k_eu= accuracy_result_eu(find(accuracy_result_eu == accuracy_eu,1),2);

% distanza cityblock
for k=1:2:20
    [train_result, validation_result,~] = knn(cv2_trainValues,cv2_trainLabels,cv2_validationValues,cv2_validationLabels,k,'cityblock');
    validation_cb= [validation_cb; validation_result];
    accuracy_result_cb= [accuracy_result_cb; validation_result.accuracy, k];
end
accuracy_cb= max(accuracy_result_cb(:,1));
k_cb= accuracy_result_cb(find(accuracy_result_cb == accuracy_cb,1),2);

% test con il training set e il K migliore
if(accuracy_cb > accuracy_eu)
    % Distanza city block
    [result_train_cb,~,c_cb]= knn(cv2_trainValues,cv2_trainLabels,cv2_validationValues,cv2_validationLabels,k_cb,'cityblock');
    class_file_name='c_cb.mat';
    %save('c_cb.mat','c_cb');
else
    % Distanza euclidea
    [result_train_eu,~,c_eu]= knn(cv2_trainValues,cv2_trainLabels,cv2_validationValues,cv2_validationLabels,k_eu,'euclidean');
    class_file_name='c_eu.mat';
    %save('c_eu.mat','c_eu');
end

% test con il test set inziale e il K migliore
if(accuracy_cb > accuracy_eu)
  %disp('Test con test set e KNN con distanza cityblock');
  test_predicted = predict(c_cb, cv1_testValues);
  test_perf = confmat(cv1_testLabels, test_predicted);
else
  %disp('Test con test set e KNN con distanza euclidea');
  test_predicted = predict(c_eu, cv1_testValues);
  test_perf = confmat(cv1_testLabels, test_predicted);
end

% test con il test set e il classificatore SVM
[result_train_svm, result_test_svm,c_svm]= svm(cv1_trainValues,cv1_trainLabels,cv1_testValues,cv1_testLabels);
%save('c_svm.mat','c_svm');
%save('data.mat','lbp','k_cb','k_eu','class_file_name','cv1_trainLabels','cv1_trainValues','cv1_testLabels','cv1_testValues')
