%% Surface Handler - Step 2
% Handles

global cut1 cut2 xmax ymax xratio yratio zratio interpmethod

%% X, Y, Z Scaling
% Scaled based on parameters of the Zygo White Light Interferometer

xratio=707/640;
yratio=530/480;
zratio=1;

%% Cutting and Masking

%% First Cut
% Left x, Right x, Bottom y, Top y, Slant
% cut1=[150,500,50,400,0];

% Interpolation methods
% 1 == inpainting-inpaint
% 2 == inpaint-griddata interp 
% 3 == griddata interp-griddata interp
% 4 == griddata interp-inpaint

interpmethod=1;

% Limits 
xmax=10;
ymax=10;

% %% Second Cut 
% %line 1 
% x5point1=150;
% y5point1=399;
% x5point2=500;
% y5point2=401;
% 
% %line 2 
% 
% x6point1=500;
% y6point1=401;
% x6point2=501;
% y6point2=50;
% 
% %line 3 
% 
% x7point1=150;
% y7point1=399;
% x7point2=151;
% y7point2=49;
% 
% %line 4 
% 
% x8point1=151;
% y8point1=49;
% x8point2=501;
% y8point2=50;
% 
% 
% cut2=[x5point1,y5point1,x5point2,y5point2;...
% x6point1,y6point1,x6point2,y6point2;...
% x7point1,y7point1,x7point2,y7point2;...
% x8point1,y8point1,x8point2,y8point2];

%% Proceed to Step 3 - Surfacing
Surfacing
