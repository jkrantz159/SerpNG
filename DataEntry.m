%% Data Entry - Step 1
% You will be prompted to enter:
% 1) The path and filename of the data relative to the location of this
% file (e.g. Zygo\JP_38_Spot_1.xyz)
% 2) The boundaries of your spot based on the interpolated figure which is
% produced.
% After entering the boundaries, the masked figure will be presented. Press
% enter to proceed with the calculations, or enter 'N' to cancel the
% program.


%% Input
% Takes input from file (.txt, .xyz)

clear all; close all; clc

global zval x_pixel y_pixel avgdepth sumvol

prompt='Enter filename, including extension:\n';
fname=input(prompt, 's');

DataFile=fopen(fname);
set(0,'defaultfigureposition',[1033 396 560 420])
%% Figures

% Figure 1: Original 
% Figure 2: Missing Points Interpolated
% Figure 3: Spot removed
% Figure 4: Orignal surface interpolation
% Figure 5: Orignal surface reduced
% Figure 6: Relevant data


%% Handling
% Extracts heights from data
header=textscan(DataFile, '%*[^\n]',14);
zdata=textscan(DataFile, '%d %d %s %*s');

zdata{1}=zdata{1}-min(zdata{1});
zdata{2}=zdata{2}-min(zdata{2});

x_pixel=max(zdata{1})+1;
y_pixel=max(zdata{2})+1;
Size=x_pixel*y_pixel;

zval=zeros(Size,1);
zdata=zdata{3};
for x=1:Size
    NaNCheck=strcmp(zdata(x),'No');
    if NaNCheck==1
        zval(x)=NaN;
    else
        zval(x)=str2double(cell2mat(zdata(x)));
    end
end

%% Proceed to Step 2 - Surface Handler
SurfaceHandler

fclose(DataFile);

disp('The average depth (in µm) of the spot is:')
disp(avgdepth)
disp('The volume (in µm^3) of the spot is:')
disp(sumvol)