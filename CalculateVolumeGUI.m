function [sumvol,avgdepth]=CalculateVolumeGUI(x_pixel,y_pixel,zfit,cut1,xratio,yratio,zratio)

zcut=zfit;

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

%% Volume 

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