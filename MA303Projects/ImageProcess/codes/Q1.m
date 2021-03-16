clear;close all
%% ԭͼ����ͼ
org=imread('crayon_paint.png');
obj=imread('crayon_paint_thinscratch.png');
figure(1);subplot(1,2,1);imshow(org);subplot(1,2,2);imshow(obj);
%% ����������ȷʵ��rgbֵΪ[0,0,0]�ĵ�
blakid=obj(:,:,1)==0 & obj(:,:,2)==0 & obj(:,:,3)==0;% rgb=[0,0,0]�ĵ�
obj_blak(:,:,1)=immultiply(blakid,255+obj(:,:,1));
obj_blak(:,:,2)=immultiply(blakid,255+obj(:,:,2));
obj_blak(:,:,3)=immultiply(blakid,255+obj(:,:,3));
figure(2)
imshow(uint8(255-obj_blak))
%% ѡ���Ե���ֵ�˲�
res_psnr=zeros(10);
obj_filt=double(obj);obj_db=double(obj);
n=70;% �����ԣ�70�����ԣ������������������̫�����Ӿ�Ч��û����������
% r=11:20
% res_psnr =
%    36.2692   35.6366   35.9309   35.4596   35.8209   35.3355   35.6730   35.2106   35.5751   35.1366    
for r=[11:20]
    for ii=1:n
        obj_filt(:,:,1)=medfilt2(obj_filt(:,:,1),[r,r]);
        obj_filt(:,:,2)=medfilt2(obj_filt(:,:,2),[r,r]);
        obj_filt(:,:,3)=medfilt2(obj_filt(:,:,3),[r,r]);
        obj_filt(:,:,1)=obj_filt(:,:,1).*blakid+obj_db(:,:,1).*~blakid;
        obj_filt(:,:,2)=obj_filt(:,:,2).*blakid+obj_db(:,:,2).*~blakid;
        obj_filt(:,:,3)=obj_filt(:,:,3).*blakid+obj_db(:,:,3).*~blakid;
    end
    result=uint8(obj_filt);
    res_psnr(r-10)=psnr(org,result);
    % �����д���ļ�
    fname=['result',int2str(r),'itr',int2str(n),'.png'];
    imwrite(result,fname);
end

