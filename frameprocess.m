function frameprocess(frame,A,i)

    cc=bwconncomp(A);
    st=regionprops(cc,'BoundingBox','Area','Perimeter');
    Areai = [st.Area];
        ll=length(Areai);
        
        for j=1:ll
    I=imcrop(A,st(j).BoundingBox);
 
    % I1=imcrop(frame,st(object_id).BoundingBox);
    %I=imfill(I,'holes');
   display(size(I));
   display(I);
   %shape detection
        
   st1 = regionprops(I, 'BoundingBox', 'Area','Perimeter' );
           
   Areai_cropped=[st1.Area];
            display(size(Areai_cropped));
   width=st1.BoundingBox(3);
   
   height=st1.BoundingBox(4);      
   
   estimate_ratio=(height/width);
  
   estimate_area_triangle=(width*height)/2;
   
  
   %upper and lower limit of triangle
   
   estimate_ratio_upper=estimate_ratio*1.05;
   
   estimate_ratio_lower=estimate_ratio*0.95;
   
   estimate_area_tri_upper=1.07*estimate_area_triangle;
   
   estimate_area_tri_lower=0.93*estimate_area_triangle;
   
    
   
   
            %checking if area of object lies in perrmissible range of area of
            %triangle
           x= (estimate_area_tri_lower<Areai_cropped);
           y= (Areai_cropped<estimate_area_tri_upper);
                l=length(x);
                
                for ii=1:l
                    if x(ii)==y(ii)
                        
                 display(Areai_cropped(ii));
                    display(estimate_area_triangle(ii));
                    display('triangle');
                    imwrite(I(ii),strjoin({num2str(i),'.jpg'}));
                    end
                end
                  
                 end
           
end
      


            






