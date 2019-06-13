function colorsegment(frame,A,i) 
        
        cc    = bwconncomp(A);
        st    = regionprops(cc,'BoundingBox','Area');
        Areai = [st.Area];

     %loading template images.
        cd tempbase
              temp_circle    = imread('circle.jpg');
              temp_dtriangle = imread('doubletriangle.jpg');
              temp_oct       = imread('octagon.jpg');
              temp_triangle  = imread('triangle.jpg');
              temp_invtri    = imread('inv_triangle.jpg');
              temp_dcircle   = imread('dcircle1.jpg');
        cd ..    
     %showing frames.   
        f = imrotate(frame,360);
        imshow(f);
        for ii=1:length(Areai)
            I = imcrop(A,st(ii).BoundingBox);
            frame_crop = imcrop(frame,st(ii).BoundingBox);
            %frame_crop = imrotate(frame_crop,90);
            test = frame_crop ;
            frame_crop = imresize(frame_crop,[50 50]);
        
        %preprocessing frame for template matching.
        
            I = im2double(I);
            I = im2bw(I,graythresh(I));
            I = imfill(I,'holes');
            I = imfill(I,'holes');
            %imshow(I);
            I = imresize(I, [50 50]);
            %I = imrotate(I,90);
             
        %correlating image with all templates.
             ans_circle    = normxcorr2(temp_circle,I);
             ans_dtriangle = normxcorr2(temp_dtriangle,I);
             ans_oct       = normxcorr2(temp_oct,I);
             ans_triangle  = normxcorr2(temp_triangle,I);
             ans_invtri    = normxcorr2(temp_invtri,I);
             ans_dcircle   = normxcorr2(temp_dcircle,I);
        %checking the value of peak with threshold.
        
          if max(ans_circle(:))>0.80
                    cd redcircle
                          %display('writing into red circle');
                          imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                          cd templ 
                          for j=1:length(dir)-2
                                signtemp = imread(strcat(strcat('a (',num2str(j)),').jpg'));
                                signtemp = rgb2gray(signtemp);
                                frame_crop1 = rgb2gray(frame_crop);
                                pleasework = normxcorr2(signtemp,frame_crop1);
                                store(j) = max(pleasework(:));
                          end
                          [maxy , idx] = max(store(:));
                          if(maxy>0.8)
                              idx =-1;
                          end    
                          if(idx ==-1)
                                idx=-1;
                          elseif(idx==1|| idx==2)
                              display('Speed : 80');
                          elseif(idx==3 || idx==5)
                              display('No overtaking');
                          elseif(idx==4 || idx==6)
                              display('Speed:60');
                          elseif(idx==7 || idx==9)
                              display('Speed:70');    
                          elseif(idx==8 || idx==11)
                              display('Speed:50');
                          elseif(idx==10)
                              display('No Left turn')
                          end       
                          cd .. 
                    cd ..            
                   X = rgb2gray(f);
                   B = rgb2gray(test);
                   C = normxcorr2(B,X);
                   [ypeak, xpeak] = find(C==max(C(:)));
                   yoffSet = ypeak-size(B,1);
                   xoffSet = xpeak-size(B,2);
                   imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);              
                   drawnow
                   
            elseif max(ans_dtriangle(:))>0.80
                    cd redtriangle
                         %display('writing into red triangle');
                         imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                    cd ..            
                    X = rgb2gray(f);
                    B = rgb2gray(test);
                    C = normxcorr2(B,X);
                    [ypeak, xpeak] = find(C==max(C(:)));
                    yoffSet = ypeak-size(B,1);
                    xoffSet = xpeak-size(B,2);
                    imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);         
                    drawnow 
            
            elseif max(ans_triangle(:))>0.85
                    cd redtriangle1
                        %display('writing into red triangle 1');
                        imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                        cd templ
                        for j=1:length(dir)-2
                                signtemp = imread(strcat(strcat('a (',num2str(j)),').jpg'));
                                signtemp = rgb2gray(signtemp);
                                frame_crop1 = rgb2gray(frame_crop);
                                pleasework = normxcorr2(signtemp,frame_crop1);
                                store(j) = max(pleasework(:));
                        end
                        [maxy , idx] = max(store(:));
                        if(maxy>0.75)
                              idx =-1;
                        end    
                        if(idx ==-1)
                            idx=-1;
                        elseif(idx==1)
                            display('Yellow sign');
                        elseif(idx==2)
                            display('Pedestrian');
                        elseif(idx==3)
                            display('Danger');
                        elseif(idx==4)
                             display('Pedestrian');    
                        end       
                        cd .. 
                    cd ..            
                    X = rgb2gray(f);
                    B = rgb2gray(test);
                    C = normxcorr2(B,X);
                    [ypeak, xpeak] = find(C==max(C(:)));
                    yoffSet = ypeak-size(B,1);
                    xoffSet = xpeak-size(B,2);
                    imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);                    
                    drawnow
                    
                    
           elseif max(ans_oct(:))>0.90
                    cd stop
                        display('Stop Sign'); 
                        imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                    cd ..
                    X = rgb2gray(f);
                    B = rgb2gray(test);
                    C = normxcorr2(B,X);
                    [ypeak, xpeak] = find(C==max(C(:)));
                    yoffSet = ypeak-size(B,1);
                    xoffSet = xpeak-size(B,2);
                    imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);                    
                    drawnow 
          
           elseif max(ans_invtri(:))>0.85
                    cd invtriangle
                        %display('writing into inverted triangle');
                        imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                        
                    cd .. 
                    X = rgb2gray(f);
                    B = rgb2gray(test);
                    C = normxcorr2(B,X);
                    [ypeak, xpeak] = find(C==max(C(:)));
                    yoffSet = ypeak-size(B,1);
                    xoffSet = xpeak-size(B,2);
                    imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);   
                    drawnow
          elseif max(ans_dcircle(:))>0.77
                    cd dcircle
                        display('writing into dcircle');
                        imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                        
                    cd .. 
                    X = rgb2gray(f);
                    B = rgb2gray(test);
                    C = normxcorr2(B,X);
                    [ypeak, xpeak] = find(C==max(C(:)));
                    yoffSet = ypeak-size(B,1);
                    xoffSet = xpeak-size(B,2);
                    imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);   
                    drawnow
                    
          end  
       end
   end

