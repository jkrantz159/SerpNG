function [zval,x_pixel,y_pixel]=DataEntryGUI(FilePathName)

fname=FilePathName;

DataFile=fopen(fname);
set(0,'defaultfigureposition',[1033 396 560 420])


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

fclose(DataFile);