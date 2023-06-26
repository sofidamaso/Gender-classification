clear all;
close all;
[images, labels]= readlists();
nimages = numel(images);
lbp =[];

 for n = 1 : nimages
    %disp(n);
    im = imread(['gender-feret-master-union\gender-feret-master\' images{n}]);
    lbp  = [lbp;compute_lbp(im)];
  end
 % save('lbp','lbp');
 %% partitioning 10% e 90%
  %cv= cvpartition(labels,'Holdout',(946-851)/946); 
 %% test classificatore
 %[tr, tv] = test_classifier(lbp,labels,cv);
%% partizione per stima del k (90% e 10%)
% con piccola parte (10%) stimo K poi uso tutto il dataset
results= [];
accuracy= [];
all_test= [];
cv= cvpartition(labels,'Holdout',(946-851)/946);
%% stima del K migliore
for k=2 : 20
    [train_result, test_result] = test_classifier(lbp,labels,cv,k);
    all_test= [all_test; test_result];
    accuracy= [accuracy; all_test(k-1).accuracy];
    %results= [results; test_classifier(lbp,labels,cv,k)];
    %accuracy= [accuracy; results(k-1).accuracy];
end
max_accuracy= max(accuracy);
k_max= (find(accuracy == max_accuracy,1))+1;
%% test con tutto il dataset con K migliore 
cv_all = cvpartition(nimages,'Resubstitution');
%cv_all= cvpartition(labels,'Holdout',(946-0)/946);
result= test_classifier(lbp,labels,cv_all,k_max);
%accuracy = result.accuracy;
%% Calcolo TPR e FPR
% tpr = result.cm_raw(1,1)/(result.cm_raw(1,1)+result.cm_raw(2,1));
% fpr = result.cm_raw(1,2)/(result.cm_raw(1,2)+result.cm_raw(2,2));
% plot(fpr, tpr)
% xlabel('False positive rate') 
% ylabel('True positive rate')
% title('ROC for Classification with KNN')
scores= [result.cm_raw(1,1) result.cm_raw(2,2)];
rocObj = rocmetrics(['Female' 'Male'],scores,result.labels);
plot(rocObj,AverageROCType="macro")


