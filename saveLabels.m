%salva un file .csv contenente le labels separate da ;
clear all;
close all;
data = fileread('images_list.list');
x = strsplit(data);
gender_labels=[];
for i=1 : numel(x)         %se il nome dell'immagine inizia per F per costruzione è una femmina
    if x{i}(1)=='F'
       gender_labels= [gender_labels 'Female'];
    elseif x{i}(1)=='M'     %se il nome inizia per M allora è una maschio
         gender_labels= [gender_labels 'Male'];
    %else non faccio niente
    end
end
%save('gender_labels','gender_labels');
% per importare in Knime è necessario avere un separatore, in questo caso ;
writematrix(gender_labels,"gender_labels.xls");
