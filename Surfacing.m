%% Surfacing

%% Inpainting NaN Values
% 

global cut1 cut2 zval xmax ymax xratio zratio yratio avgdepth interpmethod x_pixel y_pixel sumvol

z=zeros(y_pixel,x_pixel);
for y=1:y_pixel
    for x=1:x_pixel
        step=(1:x_pixel)+x_pixel.*(y-1);
        z(y,x)=zval(step(x));
    end
end

interpstyle=4; % Interpolation method used in inpaint_nans. See inpaint_nans.m for details

if interpmethod == 1 
    zfilled=inpaint_nans(z,interpstyle);
    
elseif interpmethod == 2   
    zfilled=inpaint_nans(z,interpstyle);

elseif interpmethod == 3
    x = round(rand(2000,1)*x_pixel+1);  
    y = round(rand(2000,1)*y_pixel+1);
    for p=1:numel(x);
        zpicker(p)=isfinite(z(y(p),x(p)));
    end
    counter=1;
    for p=1:numel(x)
        if zpicker(p) == 1
            xpicked(counter)=x(p);
            ypicked(counter)=y(p);
            zpicked(counter)=z(y(p),x(p));
            counter=counter+1;
        end
    end
    zfilled = griddata(xpicked,ypicked,zpicked,1:x_pixel,(1:y_pixel)','v4');

elseif interpmethod == 4
    x = round(rand(2000,1)*x_pixel+1);  
    y = round(rand(2000,1)*y_pixel+1);
    for p=1:numel(x);
        zpicker(p)=isfinite(z(y(p),x(p)));
    end
    counter=1;
    for p=1:numel(x)
        if zpicker(p) == 1
            xpicked(counter)=x(p);
            ypicked(counter)=y(p);
            zpicked(counter)=z(y(p),x(p));
            counter=counter+1;
        end
    end
    zfilled = griddata(xpicked,ypicked,zpicked,1:x_pixel,(1:y_pixel)','v4');
end

figure(1)
surf((1:x_pixel),(1:y_pixel),z)
shading interp
view(0,90)
title('Orignal Data')

figure(2)
surf((1:x_pixel),(1:y_pixel),zfilled)
shading interp
view(0,90)
colorbar
title('Missing points interpolated')

prompt='Enter left edge of spot:\n';
cut1(1)=input(prompt);
prompt='Enter right edge of spot:\n';
cut1(2)=input(prompt);
prompt='Enter bottom edge of spot:\n';
cut1(3)=input(prompt);
prompt='Enter top edge of spot:\n';
cut1(4)=input(prompt);
prompt='Enter the slant of the spot (generally 0):\n';
cut1(5)=input(prompt);

%% Masking
% Mask
zmask=zfilled;
for y=cut1(1,3):cut1(1,4)
    for x=cut1(1,1):cut1(1,2)
        slant=(x+round(cut1(1,5)*y/cut1(1,3)));
        u=(slant > 0) & (slant < x_pixel);
        if u==1
            zmask(y,slant)=nan;
        end
    end
end


zmax=max(z);
for y=cut1(1,3):cut1(1,4)
    for x=cut1(1,1):cut1(1,2)
        slant=(x+round(cut1(1,5)*y/cut1(1,3)));
        u=(slant > 0) & (slant < x_pixel);
        if u==1
            if zfilled(y,slant)>xmax*zmax(slant)
                zmask(y,slant)=zfilled(y,slant);
            else
                zmask(y,slant)=nan;
            end
        end
    end
end

zmax=(max(z,[],2));
for y=cut1(1,3):cut1(1,4)
    for x=cut1(1,1):cut1(1,2)
        slant=(x+round(cut1(1,5)*y/cut1(1,3)));
        u=(slant > 0) & (slant < x_pixel);
        if u==1
            if zfilled(y,slant)>ymax*zmax(y) 
                zmask(y,slant)=zfilled(y,slant);
            end
        end
    end
end

if interpmethod == 1 
    zg=inpaint_nans(zmask,interpstyle);
    zfit=zg-zfilled;
    
elseif interpmethod == 2
    xpicked=[];
    ypicked=[];
    zpicked=[];
    xcut=(cut1(3):cut1(4));
    ycut=cut1(1):cut1(2);
    x = round(rand(2000,1)*x_pixel+1);  
    y = round(rand(2000,1)*y_pixel+1);
    for p=1:numel(x);
        zpicker(p)=isfinite(zmask(y(p),x(p)));
    end
    counter=1;
    for p=1:numel(x)
        if zpicker(p) == 1
            xpicked(counter)=x(p);
            ypicked(counter)=y(p);
            zpicked(counter)=zmask(y(p),x(p));
            counter=counter+1;
        end
    end
    zinterp = griddata(xpicked,ypicked,zpicked,ycut,xcut','v4');
    zg=zmask;
    zg(xcut,ycut)=zinterp(1:numel(xcut),1:numel(ycut));
    zfit=zg-zfilled;

elseif interpmethod == 3
    xpicked=[];
    ypicked=[];
    zpicked=[];
    xcut=(cut1(3):cut1(4));
    ycut=cut1(1):cut1(2);
    x = round(rand(2000,1)*x_pixel+1);  
    y = round(rand(2000,1)*y_pixel+1);
    for p=1:numel(x);
        zpicker(p)=isfinite(zmask(y(p),x(p)));
    end
    counter=1;
    for p=1:numel(x)
        if zpicker(p) == 1
            xpicked(counter)=x(p);
            ypicked(counter)=y(p);
            zpicked(counter)=zmask(y(p),x(p));
            counter=counter+1;
        end
    end
    zinterp = griddata(xpicked,ypicked,zpicked,ycut,xcut','v4');
    zg=zmask;
    zg(xcut,ycut)=zinterp(1:numel(xcut),1:numel(ycut));
    zfit=zg-zfilled;

elseif interpmethod == 4 
    zg=inpaint_nans(zmask,interpstyle);
    zfit=zg-zfilled;
end

figure(3)
surf((1:x_pixel),(1:y_pixel),zmask)
shading interp
view(0,90)
colorbar
title({'Cut 1';'Spot removed'})

prompt='Press enter to proceed. Enter N to cancel.\n';
errorcode=input(prompt,'s');
if errorcode=='N'
    error('Aborted by user')
end

% Cut 2 
zcut=zfit;
% for w=1:4
%     xinterval=linspace(cut2(w,1),cut2(w,3),(cut2(w,3)-cut2(w,1)));
%     sniper=zeros(x_pixel,1); 
%     for x=1:numel(xinterval) 
%         sniper(x+cut2(w,1),1)=(cut2(w,4)-cut2(w,2))./(cut2(w,3)-cut2(w,1))*(xinterval(x)-cut2(w,1))+cut2(w,2);
%     end
%     
%     if w==1
%         for y=1:y_pixel
%             for x=cut2(w,1):cut2(w,3)
%                 if y>sniper(x)
%                     zcut(y,x)=NaN;
%                 end
%             end
%         end
%     end
%     
%     if w==2
%         for y=1:y_pixel
%             for x=cut2(w,1)+1:cut2(w,3)
%                 if y>sniper(x)
%                     zcut(y,x)=nan;
%                 end
%             end
%         end
%     end
%     
%     if w==3
%         for y=1:y_pixel
%             for x=cut2(w,1):cut2(w,3)
%                 if y<sniper(x)
%                     zcut(y,x)=nan;
%                 end
%             end
%         end
%     end
%     
%     if w==4
%         for y=1:y_pixel
%             for x=cut2(w,1):cut2(w,3)
%                 if y<sniper(x)
%                     zcut(y,x)=nan;
%                 end
%             end
%         end
%     end
% end

for x=1:x_pixel
    for y=1:y_pixel
        if x<cut1(1) || x>cut1(2)
            zcut(y,x)=nan;
        end
        if y<cut1(3) || y>cut1(4)
            zcut(y,x)=nan;
        end
    end
end



% Volume 

vol=zeros(y_pixel,x_pixel);
sumvol=zeros(1,1);
numsum=zeros(1,1);

for y=1:y_pixel
    for x=1:x_pixel
        vol(y,x)=yratio*xratio.*zratio.*zcut(y,x);
    end
end

for y = 1:y_pixel
    for x=1:x_pixel
        if vol(y,x)>0;
            sumvol=sumvol+vol(y,x);
            numsum=numsum+1;
        end
    end
end

avgdepth=sumvol./numsum./(yratio*xratio);

figure(4)
surf((1:x_pixel),(1:y_pixel),zg)
shading interp
colorbar
view(0,90)
title('Interpolated original surface')

figure(5)
surf((1:x_pixel),(1:y_pixel),zfit)
shading interp
view(0,90)
colorbar
title({'Original Surface Reduced';'Figure 2 minus Figure 4'})

figure(6)
surf((1:x_pixel),(1:y_pixel),zcut)
shading interp
view(0,90)
colorbar
title({'Relevant portion of data';'Exclude areas with non-zero values which are not part of the pit'})

clear zpicker ypicked xpicked zpicked