function[centroid]=colorsegment(frame,A,i,centroid) 
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
             temp_dcircle   = imread('dcircle1.jpg');
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
            I = imfill(I,'holes');
           
            I = imresize(I, [50 50]);
        %displaying image and its frame.
         %imshowpair(I,frame_crop,'montage');
      
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
        
                    if(centroid(1,:)==0)
                        
                           cd temp 
                          for j=1:length(dir)-2
                                signtemp = imread(strcat(strcat('a (',num2str(j)),').jpg'));
                                signtemp = rgb2gray(signtemp);
                                frame_crop1 = rgb2gray(frame_crop);
                                pleasework = normxcorr2(signtemp,frame_crop1);
                                store(j) = max(pleasework(:));
                          end
                          [maxy , idx] = max(store(:));
                             
                          if(idx ==-1)
                                idx=-1;
                          elseif(idx==1|| idx==2)
                              %display('Speed : 80');
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','speed:80','FontSize',14);
                          elseif(idx==3 || idx==5)
                              display('No overtaking');
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','no overtaking','FontSize',14);
                          elseif(idx==4 || idx==6)
                              display('Speed:60');
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','speed:60','FontSize',14);
                          elseif(idx==7 || idx==9)
                              display('Speed:70'); 
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','speed:70','FontSize',14);
                          elseif(idx==8 || idx==11)
                              display('Speed:50');
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','speed:50','FontSize',14);
                          elseif(idx==10)
                              display('No Left turn')
                              annotation('textbox',[0.15 0.65 0.3 0.15],'string','No left turn','FontSize',14);
                          end       
                          cd .. 
                             
                       
                              display('writing into red circle');
                             centroid(1,:)=[x_coordinate y_coordinate];
                            
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
                    
            elseif max(ans_dtriangle(:))>0.80
                    cd redtriangle
                          if(centroid(1,:)==0)
                        
                             display('writing into red triangle');
                             centroid(1,:)=[x_coordinate y_coordinate];
                              display(centroid);
                             imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                             cd ..
                             flag=1;
                    else
                            
                             if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
                                 centroid(1,:)=[x_coordinate y_coordinate];
                             else  
                                centroid=zeros(2,2);
                             end
                             cd ..
                             flag=1;
                             
                          end
           elseif max(ans_triangle(:))>0.85
                    cd redtriangle1
                        if(centroid(1,:)==0)
                         cd temp
                        for j=1:length(dir)-2
                                signtemp = imread(strcat(strcat('a (',num2str(j)),').jpg'));
                                signtemp = rgb2gray(signtemp);
                                frame_crop1 = rgb2gray(frame_crop);
                                pleasework = normxcorr2(signtemp,frame_crop1);
                                store(j) = max(pleasework(:));
                        end
                        [maxy , idx] = max(store(:));
                          
                        if(idx ==-1)
                            idx=-1;
                        elseif(idx==1)
                            display('Yellow sign');
                            annotation('textbox',[0.15 0.65 0.3 0.15],'string','Yellow sign','FontSize',14);
                        elseif(idx==2)
                            display('Pedestrian');
                            annotation('textbox',[0.15 0.65 0.3 0.15],'string','Pedestrian','FontSize',14);
                        elseif(idx==3)
                            display('Danger');
                            annotation('textbox',[0.15 0.65 0.3 0.15],'string','Danger','FontSize',14);
                        elseif(idx==4)
                             display('Pedestrian');  
                             annotation('textbox',[0.15 0.65 0.3 0.15],'string','Pedestrian','FontSize',14);
                        end       
                        cd .. 
                             display('writing into red triangle1');
                             centroid(1,:)=[x_coordinate y_coordinate];
                              
                             imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                             cd ..
                             flag=1;
                    else
                            
                             if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
                                 centroid(1,:)=[x_coordinate y_coordinate];
                             else  
                                centroid=zeros(2,2);
                             end
                             cd ..
                             flag=1;
                        end
                    
           elseif max(ans_oct(:))>0.80
                    cd octagon
                        if(centroid(1,:)==0)
                        
                             
                                        annotation('textbox',[0.15 0.65 0.3 0.15],'string','STOP','FontSize',14);
                                    fprintf('octagon detected');
                               
                             display('writing into octagon');
                             centroid(1,:)=[x_coordinate y_coordinate];
                              
                             imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                             cd ..
                             flag=1;
                    else
                            
                             if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
                                 centroid(1,:)=[x_coordinate y_coordinate];
                             else  
                                centroid=zeros(2,2);
                             end
                             cd ..
                             flag=1;
                        end
           elseif max(ans_invtri(:))>0.85
                    cd invtriangle
                        if(centroid(1,:)==0)
                        
                             display('writing into inverted triangle');
                             centroid(1,:)=[x_coordinate y_coordinate];
                             imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                             cd ..
                             flag=1;
                    else
                            
                             if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
                                 centroid(1,:)=[x_coordinate y_coordinate];
                             else  
                                centroid=zeros(2,2);
                             end
                             cd ..
                             flag=1;
                                     
        
                        end
                        
                elseif max(ans_dcircle(:))>0.77
                   
                    cd dcircle
                    if(centroid(1,:)==0)
                        display('writing into dcircle');
                        imwrite(frame_crop,strcat(num2str(i),'.jpg'));
                         annotation('textbox',[0.15 0.65 0.3 0.15],'string','SIGN AHEAD','FontSize',14);
                       
                    cd .. 
                      flag=1;
                    else if((centroid(1,1)>=appro_x_coor_lower&&centroid(1,1)<=appro_x_coor_upper)&&(centroid(1,2)>=appro_y_coor_lower&&centroid(1,2)<=appro_y_coor_upper))
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

