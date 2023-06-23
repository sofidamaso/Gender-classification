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
