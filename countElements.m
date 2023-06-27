function [female,male] = countElements(cv_labels)
female=sum(strcmp(cv_labels,'Female'),"all");
male=sum(strcmp(cv_labels,'Male'),"all");
end