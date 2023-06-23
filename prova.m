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
  cv= cvpartition(labels,'Holdout',(946-851)/946); 
 %% test classificatore
 [tr, tv] = test_classifier(lbp,labels,cv);
%% stima del K migliore
 % con piccola parte (10%) stimo K poi uso tutto il dataset
results= [];
accuracy= [];
cv= cvpartition(labels,'Holdout',(946-851)/946);
for k=2 : 100
    results= [results; test_classifier(lbp,labels,cv,k)];
    accuracy= [accuracy; results(k-1).accuracy];
end
max_accuracy= max(accuracy);
k_max= (find(max_accuracy))+1;
%% test con tutto il dataset con K migliore 
cv_all= cvpartition(labels,'Holdout',(946-0)/946);
result = test_classifier(lbp,labels,cv_all,k_max);
%accuracy = result.accuracy;