%Questa funzione utilizza a sua la volta la funzione confusionmat per
%calcolare la matrice di confusione e ritorna una stuct contenente:
% 1) la matrice di confusione 
% 2) la matrice di confusione con valori tra 0 e 1
% 3) l'elenco ordinato delle labels
% 4) il valore di accuratezza 
function out=confmat(gt,predicted)

  [cm_raw,order]=confusionmat(gt(:),predicted(:));
  
  out.cm_raw = cm_raw;
  out.cm = cm_raw./repmat(sum(cm_raw,2),1,size(cm_raw,2));
  out.labels = order;
  out.accuracy = sum(diag(cm_raw))/numel(gt);
end