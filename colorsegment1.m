function[centroid]=colorsegment1(frame,A,i,centroid) 
    cc    = bwconncomp(A);
    st    = regionprops(cc,'BoundingBox','Area');
    Areai = [st.Area];
    flag =0;
    
          
        %loading template images.
      cd tempbase
             temp_circle    = imread('circle.jpg');
             temp_dtriangle = imread('doubletriangle.jpg');
             temp_oct       = imread('octagon.jpg');
             temp_triangle  = imread('triangle.jpg');
             temp_invtri    = imread('inv_triangle.jpg');
      cd ..
        %f=imrotate(frame,270);
       f=frame;
        
        %finding largest id and cropping image and frame.
        %largest_id = find(Areai==max(Areai));
        for ii=1:length(Areai)
            bb=st(ii).BoundingBox;
            I = imcrop(A,bb);
            frame_crop = imcrop(frame,bb);
           % frame_crop = imrotate(frame_crop,270);
            test=frame_crop;
            frame_crop = imresize(frame_crop,[50 50]);
            
            %centroid of the bounding box
            x_coordinate=bb(1)+bb(3)/2;
            y_coordinate=bb(2)+bb(4)/2;
            appro_x_coor_lower=x_coordinate*0.95;
            appro_x_coor_upper=x_coordinate*1.05;
            appro_y_coor_lower=y_coordinate*0.95;
            appro_y_coor_upper=y_coordinate*1.05;
            
           %preprocessing frame for template matching.
        
            I = im2double(I);
            I = im2bw(I,graythresh(I));
            I = imfill(I,'holes');
            I = imrotate(I,270);
            I = imresize(I, [50 50]);
        %displaying image and its frame.
         %imshowpair(I,frame_crop,'montage');
      
        %correlating image with all templates.
             ans_circle    = normxcorr2(temp_circle,I);
             ans_dtriangle = normxcorr2(temp_dtriangle,I);
             ans_oct       = normxcorr2(temp_oct,I);
             ans_triangle  = normxcorr2(temp_triangle,I);
             ans_invtri    = normxcorr2(temp_invtri,I);
        %checking the value of peak with threshold.
        
          if max(ans_circle(:))>0.85
                    cd bluecircle
        
                    if(centroid(1,:)==0)
                        
                             display('writing into blue circle');
                             centroid(1,:)=[x_coordinate y_coordinate];
                             display(centroid);
                             imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                             cd ..
                             
                             flag = 1;
                    else
                            
                             if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
                                 centroid(1,:)=[x_coordinate y_coordinate];
                             else  
                                centroid=zeros(2,2);
                             end
                             cd ..
                             flag=1;
                             
                    end
                    
           
              
         
          end
           if(flag==1)
               drawbound(f,test);
               flag=0;
           end
          
       end
   end

