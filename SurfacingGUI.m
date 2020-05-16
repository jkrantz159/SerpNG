function [x_pixel,y_pixel,z,zfilled]=SurfacingGUI(x_pixel,y_pixel,zval)

%% Surfacing

%% Inpainting NaN Values


z=zeros(y_pixel,x_pixel);
for y=1:y_pixel
    for x=1:x_pixel
        step=(1:x_pixel)+x_pixel.*(y-1);
        z(y,x)=zval(step(x));
    end
end

% Interpolation methods
% 1 == inpainting-inpaint
% 2 == inpaint-griddata interp 
% 3 == griddata interp-griddata interp
% 4 == griddata interp-inpaint

interpmethod=1;

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

