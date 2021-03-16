clear;
close all
%% read object
g=imread('barbara_motionblurred.png');

%% test code block
% f=imread('barbara.png');
% f=double(f);
% kernel=fspecial('motion',20,40);
% g=imfilter(f,kernel,'replicate');

%% estimate motion kernel
% [est_theta,est_len]=ThetaLengthEstimate(g,false); % Default estimate
% [est_theta,est_len]=ThetaLengthEstimate(g,false,true); % Search best S
est_theta=40/180*pi; est_len=14; % Estimated by the curve of S for Q3(3)

%% print estimated result
disp('estimated theta is')
disp(est_theta);
disp('it equals to(degree):')
disp(est_theta/pi*180)
disp('estimated length is')
disp(est_len);
%% deblur
kernel=fspecial('motion',est_len,est_theta/pi*180);
f_deblr_lucy=deconvlucy(g,kernel);
f_deblr=lin_inv(g,kernel); % For replicate boundary condition
% f_deblr=deconvreg(g,kernel); % For circular boundary condition. One can deal
%  with symmetric boundary condition making use of the method for circular.
%% psnr compute
f=imread('barbara.png');
psnr_deblr=psnr(uint8(f_deblr),uint8(f));
disp('Deblured psnr is')
disp(psnr_deblr);

% psnr_deblr_lucy=psnr(uint8(f_deblr_lucy),uint8(f),100);
% disp('Deblured psnr using deconvlucy is')
% disp(psnr_deblr_lucy);

g=uint8(g);
psnr_g=psnr(uint8(g),uint8(f))

%% imshow
figure
imshow(uint8(f_deblr))

% figure
% imshow(uint8(f_deblr_lucy))

figure
imshow(uint8(g))
figure
imshow(uint8(f))
