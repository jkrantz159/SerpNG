%% Surface Handler - Step 2
% Handles


global cut1 cut2 xmax ymax xratio yratio zratio interpmethod

%x, y, z scales
xratio=707/640;
yratio=530/480;
zratio=88.666/88.666;

% left x, right x, bottom y, top y, slant
cut1=[200,450,100,310,0];

%interp method
% 1 == inpainting-inpaint
% 2 == inpaint-griddata interp 
% 3 == griddata interp-griddata interp
% 4 == griddata interp-inpaint

interpmethod=1;

% limits 
xmax=10;
ymax=10;
% First Cut


% Second Cut 
%line 1 
x5point1=1;
y5point1=450;
x5point2=50;
y5point2=479;

%line 2 

x6point1=600;
y6point1=479;
x6point2=639;
y6point2=500;

%line 3 

x7point1=600;
y7point1=1;
x7point2=639;
y7point2=2;

%line 4 

x8point1=1;
y8point1=50;
x8point2=50;
y8point2=1;

cut2=[x5point1,y5point1,x5point2,y5point2;...
x6point1,y6point1,x6point2,y6point2;...
x7point1,y7point1,x7point2,y7point2;...
x8point1,y8point1,x8point2,y8point2];

volumespot




