function [zmask,zfit]=MaskingGUI(zfilled,cut1,interpmethod,x_pixel,y_pixel,z)

%% Masking
% Mask

interpstyle=4; % Interpolation method used in inpaint_nans. See inpaint_nans.m for details

xmax=10;
ymax=10;

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