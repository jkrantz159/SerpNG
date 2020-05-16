global cut1 cut2 x_pixel y_pixel zval xmax ymax xratio yratio zratio

z=zeros(y_pixel,x_pixel);
for y=1:y_pixel
for x=1:x_pixel
step=(1:640)+640.*(y-1);
z(y,x)=zval(step(x));
end
end
zfilled=inpaint_nans(z,4);
figure(1)
surf((1:640),(1:480),z)
shading interp
view(0,90)
figure(2)
surf((1:640),(1:480),zfilled)
shading interp
view(0,90)
colorbar
% mask
zmask=zfilled;
for y=cut1(1,3):cut1(1,4)
for x=cut1(1,1):cut1(1,2)
    slant=(x+round(cut1(1,5)*y/cut1(1,3)));
    u=(slant > 0) & (slant < 640);
if u==1
zmask(y,slant)=nan;
end
end
end


zmax=(max(z));
for y=cut1(1,3):cut1(1,4)
for x=cut1(1,1):cut1(1,2)
    slant=(x+round(cut1(1,5)*y/cut1(1,3)));
    u=(slant > 0) & (slant < 640);
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
    u=(slant > 0) & (slant < 640);
if u==1
if zfilled(y,slant)>ymax*zmax(y) 
    zmask(y,slant)=zfilled(y,slant);
end
end
end
end
    

% %line 2
% xinterval=linspace(x2point1,x2point2,(x2point2-x2point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x2point1-1,1)=(y2point2-y2point1)./(x2point2-x2point1)*(xinterval(x)-x2point1)+y2point1;
% end
% for y=1:480
% for x=x2point1:x2point2
% if y<sniper(x)
%     z(y,x)=nan;
% end
% end
% end
% 
% %line 3
% xinterval=linspace(x3point1,x3point2,(x3point2-x3point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x3point1-1,1)=(y3point2-y3point1)./(x3point2-x3point1)*(xinterval(x)-x3point1)+y3point1;
% end
% for y=1:480
% for x=x3point1:x3point2
% if y>sniper(x)
%     z(y,x)=nan;
% end
% end
% end
% 
% %line 4
% xinterval=linspace(x4point1,x4point2,(x4point2-x4point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x4point1-1,1)=(y4point2-y4point1)./(x4point2-x4point1)*(xinterval\(x)-x4point1)+y4point1;
% end
% for y=1:480
% for x=x4point1:x4point2
% if y>sniper(x)
%     z(y,x)=nan;
% end
% end
% end
% t=1;
% for y=1:480
% for x=1:640
% if zprotomask(y,x)>xmax*zmax(x)
%     zmask(y,x)=zfilled(y,x);
% else
%     zmask(y,x)=nan;
% end
% end
% end
% zmax=(max(z,[],2));
% for y=1:480
% for x=1:640
% if zfilled(y,x)>ymax*zmax(y) 
%     zmask(y,x)=zfilled(y,x);
% 
% end
% end
% end
x=rand(307200,1)*640-320;
y=rand(307200,1)*480-240;
x1=640;
y1=480;

zg=inpaint_nans(zmask,2);
zfit=zg-zfilled;
zfitcol=zval;
for y=1:480
step=(1:640)+640.*(y-1);
zfitcol(step,3)=zfit(y,1:640);
end


%second cut 
zcut=zfit;
for w=1:4
xinterval=linspace(cut2(w,1),cut2(w,3),(cut2(w,3)-cut2(w,1)));
sniper=zeros(640,1); 
for x=1:numel(xinterval) 
sniper(x+cut2(w,1),1)=(cut2(w,4)-cut2(w,2))./(cut2(w,3)-cut2(w,1))*(xinterval(x)-cut2(w,1))+cut2(w,2);
end
if w==1
for y=1:480
for x=cut2(w,1):cut2(w,3)
if y>sniper(x)
    zcut(y,x)=nan;
end
end
end
end
if w==2
for y=1:480
for x=cut2(w,1)+1:cut2(w,3)
if y>sniper(x)
    zcut(y,x)=nan;
end
end
end
end
if w==3
for y=1:480
for x=cut2(w,1):cut2(w,3)
if y<sniper(x)
    zcut(y,x)=nan;
end
end
end
end
if w==4
for y=1:480
for x=cut2(w,1):cut2(w,3)
if y<sniper(x)
    zcut(y,x)=nan;
end
end
end
end
end

% %line 5
% xinterval=linspace(x5point1,x5point2,(x5point2-x5point1));
% sniper=zeros(640,1); 
% for x=1:numel(xinterval) 
% sniper(x+x5point1,1)=(y5point2-y5point1)./(x5point2-x5point1)*(xinterval(x)-x5point1)+y5point1;
% end
% for y=1:480
% for x=x5point1:x5point2
% if y>sniper(x)
%     zcut(y,x)=nan;
% end
% end
% end
% 
% %line 6
% xinterval=linspace(x6point1,x6point2,(x6point2-x6point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x6point1-1,1)=(y6point2-y6point1)./(x6point2-x6point1)*(xinterval(x)-x6point1)+y6point1;
% end
% for y=1:480
% for x=x6point1:x6point2
% if y>sniper(x)
%     zcut(y,x)=nan;
% end
% end
% end
% 
% %line 7
% xinterval=linspace(x7point1,x7point2,(x7point2-x7point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x7point1-1,1)=(y7point2-y7point1)./(x7point2-x7point1)*(xinterval(x)-x7point1)+y7point1;
% end
% for y=1:480
% for x=x7point1:x7point2
% if y<sniper(x)
%     zcut(y,x)=nan;
% end
% end
% end
% 
% %line 8
% xinterval=linspace(x8point1,x8point2,(x8point2-x8point1));
% sniper=zeros(640,1);  
% for x = 1:numel(xinterval) 
% sniper(x+x8point1-1,1)=(y8point2-y8point1)./(x8point2-x8point1)*(xinterval(x)-x8point1)+y8point1;
% end
% for y=1:480
% for x=x8point1:x8point2
% if y<sniper(x)
%     zcut(y,x)=nan;
% end
% end
% end
% 

%volume 
vol=zeros(480,640);
sumvol=zeros(1,1);
for y=1:480
vol(y,1:640)=yratio.*xratio.*zratio.*zcut(y,1:640);
end

volpicked=isfinite(vol);
for y = 1:480
    for x=1:640
    if volpicked(y,x)==1;
        sumvol=sumvol+vol(y,x);
    end
    end
end

figure(3)
surf((1:640),(1:480),zmask)
shading interp
view(0,90)
colorbar
figure(4)
surf((1:640),(1:480),zg)
shading interp
colorbar
view(0,90)
figure(5)
surf((1:640),(1:480),zfit)
shading interp
view(0,90)
colorbar
figure(6)
surf((1:640),(1:480),zcut)
shading interp
view(0,90)
colorbar

