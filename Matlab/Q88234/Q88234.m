img = imread("Q88234.PNG");
psf = fspecial("disk", 21);
deconv_img = deconvlucy(img,psf);

figure(1);
imshow(img);

figure(2);
imshow(deconv_img);

figure(3);
dot1 = img([420:490]-75, [108:175]+50);
imshow(dot1);

figure(4);
dot2 = img([420:490]-75, [108:175]+320);
imshow(dot2);

deconv_dot1 = deconvlucy(dot1, psf);
deconv_dot2 = deconvlucy(dot2, psf);

figure(5);
imshow(deconv_dot1)

figure(6);
imshow(deconv_dot2)

