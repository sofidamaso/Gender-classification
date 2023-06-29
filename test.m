load('data.mat');
load('c_cb.mat');
load('c_eu.mat');
load('c_svm.mat');
s= sprintf('Matrice di confusione classificatore KNN con k= %d e distanza Cityblock',k_cb);
disp(s);
test_predicted = predict(c_cb, cv1_testValues);
test_perf = confmat(cv1_testLabels, test_predicted);
test_perf.cm
a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
disp(a);

s= sprintf('Matrice di confusione classificatore KNN con k= %d e distanza Euclidea',k_eu);
disp(s);
test_predicted = predict(c_eu, cv1_testValues);
test_perf = confmat(cv1_testLabels, test_predicted);
test_perf.cm
a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
disp(a);

disp('Matrice di confusione classificatore SVM');
test_predicted = predict(c_svm, cv1_testValues);
test_perf = confmat(cv1_testLabels, test_predicted);
test_perf.cm
a= sprintf('Accuracy sul test set: %f \n',test_perf.accuracy);
disp(a);