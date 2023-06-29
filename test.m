% Script che permette di caricare dei dati precedentemente salvati e
% visualizzare le performance sul test set e la matrice di confusione di due classificatori:
% 1) classificatore KNN con la combinazione migliore di metrica di distanza
% (cityblock o euclidea) e valore di K
% 2) classificatore SVM

load('data.mat');
load('c_svm.mat');

if strcmp(class_file_name,'c_cb.mat') == 1
    load('c_cb.mat');
    s= sprintf('Matrice di confusione classificatore KNN con distanza City Block e k= %d',k_cb);
    disp(s);
    test_predicted = predict(c_cb, cv1_testValues);
    test_perf = confmat(cv1_testLabels, test_predicted);
    test_perf.cm
    a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
    disp(a);
else
    if strcmp(class_file_name,'c_eu.mat') == 1
        load('c_eu.mat');
        s= sprintf('Matrice di confusione con distanza Euclidea e k= %d',k_eu);
        disp(s);
        test_predicted = predict(c_eu, cv1_testValues);
        test_perf = confmat(cv1_testLabels, test_predicted);
        test_perf.cm
        a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
        disp(a); 
    end
end

disp('Matrice di confusione classificatore SVM');
test_predicted = predict(c_svm, cv1_testValues);
test_perf = confmat(cv1_testLabels, test_predicted);
test_perf.cm
a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
disp(a);