%salva un file .xls contenente le labels 
clear;
data = fileread('images_list.list');
x = strsplit(data);
gender_labels=[];
for i=1 : numel(x)         %se il nome dell'immagine inizia per F per costruzione è una femmina
    if x{i}(1)=='F'
       gender_labels= [gender_labels; 'Female'];
    elseif x{i}(1)=='M'     %se il nome inizia per M allora è una maschio
         gender_labels= [gender_labels; 'Male  '];
    end
end
writematrix(gender_labels,"gender_labels.xls");
