% Funzione che permette di calcolare il numero di elementi appartenenti a
% ciascuna classe quando si esegue una partizione con la funzione cvpartition
function [female,male] = countElements(cv_labels)
    female=sum(strcmp(cv_labels,'Female'),"all");
    male=sum(strcmp(cv_labels,'Male'),"all");
end