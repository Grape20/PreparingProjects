clear;close all
% fname='Book_watermarked.png';
fname='excel_elite.jpeg'; % another image
org=imread(fname);
org=rgb2gray(org); % for a colorful image
brightest=max(org,[],'all');
darkest=min(org,[],'all');
% upper and lower fence
bright_fence=brightest-20;
dark_fence=darkest+80;

% filt index, identify the watermark
filtid=((org>dark_fence) & (org<bright_fence));

filt=org;
filt(filtid)=brightest; % set the watermark to white
res=uint8(filt);
figure(1)
imshow(org);
figure(2)
imshow(res);
