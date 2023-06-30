  % Questa funzione testa un classificatore KNN con i dati e le labels fornite. 
  % In questo caso i dati sono i risultati del LBP applicato alle
  % partizioni ottenute con la funzione cvpartition.
  % In input vengono forniti sia i valori che le labels, sia per il
  % training set che per il test set (o validation set). Inoltre vengono
  % passati anche il valore di K (numero di vicini da considerare) e una
  % stringa, che indica la tipologia di funzione di distanza da utilizzare
  % per il classificatore KNN.
  % La funzione ritorna le performance del classificatore in fase di training e in
  % fase di test (o validation) e il vero e proprio classificatore.
function [train_perf, test_perf,c] = knn(train_values,train_labels,test_values,test_labels, k, distance)
  c = fitcknn(train_values, train_labels,'NumNeighbors',k, 'Distance', distance);
  
  train_predicted = predict(c, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c, test_values);
  test_perf = confmat(test_labels, test_predicted);
    
end