function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.

  [images, labels] = readlists();
    
  nimages = numel(images);
  
  lbp =[];
  cedd = [];
  qhist = [];
  
  for n = 1 : nimages
    %disp(n);
    im = imread(['ALL/all images/' images{n}]);
    lbp   = [lbp;compute_lbp(im)];
    %cedd  = [cedd;compute_CEDD(im)];
    %qhist = [qhist;compute_qhist(im)];
  end
  
  save('lbp','lbp');
 % save('cedd','cedd');     
  %save('qhist','qhist');
   
end