  % Questa funzione testa un classificatore SVM con i dati e le labels fornite. 
  % In questo caso i dati sono i risultati del LBP applicato alle
  % partizioni ottenute con la funzione cvpartition.
  % In input vengono forniti sia i valori che le labels, sia per il
  % training set che per il test set (o validation set). 
  % La funzione ritorna le performance del classificatore in fase di training e in
  % fase di test (o validation).
function [train_perf, test_perf] = svm(train_values,train_labels,test_values,test_labels)
  c= fitcsvm(train_values,train_labels);        

  train_predicted = predict(c, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c, test_values);
  test_perf = confmat(test_labels, test_predicted);
end