%Questa funzione permette di leggere il contenuto di un file (dopo averlo
%aperto) e di creare due array di celle. Essi contengono rispettivamente
%l'elenco delle immagini e l'elenco delle labels corrispondenti.
function [images,labels]=readlists()

  f=fopen('images_list.list');
  z = textscan(f,'%s');
  images = z{:}; 
  fclose(f);

  f=fopen('labels.list');
  l = textscan(f,'%s');
  labels= l{:};
  fclose(f);
end
