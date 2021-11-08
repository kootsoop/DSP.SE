refimg = im2double(imread('cameraman.tif')); % original image
img_height = size(refimg,1);
img_width = size(refimg,2);
refimg = refimg(1:img_height,1:img_width);

rng(0);
r1 = random('Normal',0, 1,[img_height img_width]);
r2 = random('Normal',0, 1,[img_height img_width]);

n = 0.02; % the noise level
u0 = refimg + n.*(r1./r2);

figure(1); imshow(u0);

PSNR_noisy = psnr(refimg,u0)