function [train_perf, test_perf] = test_classifier(descriptor, labels, cv, k)
  % Testa un classificatore con i dati descrittori e partizionamento.
  % Parametri: 
  %   descriptor : descrittore/i da usare per la classificazione
  %   labels : etichette delle immagini
  %   cv : output di cvpartition con le partizioni train set / test set
  %   k : è il numero dei vicini considerato dal KNN
  %
  %   Ritorna le performance del classificatore in fase di training e in
  %   fase di test
  
  train_values = descriptor(cv.training,:);
  train_labels = labels(cv.training);
  
  test_values  = descriptor(cv.test,:);
  test_labels  = labels(cv.test);
  
  % ADDESTRARE IL CLASSIFICATORE
  c = fitcknn(train_values, train_labels,'NumNeighbors',k);
  %c= fitcsvm(train_values,train_labels);        %SVM
  
  train_predicted = predict(c, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c, test_values);
  test_perf = confmat(test_labels, test_predicted);
    
end