kernel=fspecial('motion',est_len,est_theta/pi*180);
range=10:1:30;psnr_deblr=[];
for iter=range
    f_deblr=lin_inv(g,kernel,iter); % For replicate boundary condition
    f=imread('barbara.png');
    psnr_deblr=[psnr_deblr,psnr(uint8(f_deblr),uint8(f))];
end
disp(range)
disp(psnr_deblr)

    