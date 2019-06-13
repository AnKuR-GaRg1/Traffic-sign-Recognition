close all;
clear all;

cd traffictemp
len = length(dir);
for i=1:len-3
      img  = imread(strcat(strcat('a (',num2str(i)),').jpg'));
      [m,n,l]= size(img);
      if (l==3)
        img = rgb2gray(img);
        
      end 
     
      cd tempbase 
      
            img = imresize(img,[50,50]);
            imwrite(img,strcat(num2str(i),'.jpg'));
            %imwrite(~gray_bin,strcat(num2str(i),'n.jpg'));
      cd ..      
      
end 
cd ..
