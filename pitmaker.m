global plan x_pixel y_pixel num_pixel
%creates pit vector
x_pixel=4;
y_pixel=4;
num_pixel=x_pixel*y_pixel; % # of pixels in image 
pit=fopen('Test.txt');
plan=zeros(num_pixel,1);
build=textscan(pit, '%*d %*d %s %*s');
built=build{1,1};
for x=1:num_pixel
TF=strcmp(built(x),'No');
if TF==1
    plan(x)=nan;
else
    plan(x)=str2double(cell2mat(built(x)));
end
end