function DemoExpriment1II()
imgI = im2double(rgb2gray(imread('Reference/2/F1.BMP')));
imgP = im2double(rgb2gray(imread('Reference/2/F2.BMP')));

[imgcomp1,MVx1,MVy1,PSNR1]=LogSearch(8,4,imgI,imgP);
[imgcomp2,MVx2,MVy2,PSNR2]=LogSearch(8,8,imgI,imgP);
[imgcomp3,MVx3,MVy3,PSNR3]=LogSearch(8,16,imgI,imgP);
 [imgcomp4,MVx4,MVy4,PSNR4]=LogSearch(8,32,imgI,imgP);

 [imgcomp5,MVx5,MVy5,PSNR5]=LogSearch(4,16,imgI,imgP);
[imgcomp6,MVx6,MVy6,PSNR6]=LogSearch(8,16,imgI,imgP);
[imgcomp7,MVx7,MVy7,PSNR7]=LogSearch(16,16,imgI,imgP);
 [imgcomp8,MVx8,MVy8,PSNR8]=LogSearch(32,16,imgI,imgP);

figure(1);
title('Experiment1-I');
subplot(421);
T = sprintf('4Pixel-PSNR %3g dB', PSNR1);
imshow(imgcomp1); title(T);

subplot(422);
T = sprintf('Time %3g s', 0.047);
quiver(MVx1, MVy1);title(T);

subplot(423);
T = sprintf('8Pixel-PSNR %3g dB', PSNR2);
imshow(imgcomp2); title(T);

subplot(424);
T = sprintf('Time %3g s', 0.365);
quiver(MVx2, MVy2);title(T);

subplot(425);
T = sprintf('16Pixel-PSNR %3g dB', PSNR3);
imshow(imgcomp3); title(T);

subplot(426);
T = sprintf('Time %3g s', 0.414);
quiver(MVx3, MVy3);title(T);

subplot(427); 
T = sprintf('32Pixel-PSNR %3g dB', PSNR4);
imshow(imgcomp4); title(T);

subplot(428);
T = sprintf('Time %3g s', 0.471);
quiver(MVx4, MVy4);title(T);


figure(2);
title('MotionCompensatedPicture-FSM-ExperimentI-C');
imshow(imgcomp3);

figure(3);
title('MotionVector-FSM-ExperimentI-C')
quiver(MVx3, MVy3);




figure(4);
title('Experiment1-I-CSA');
subplot(421);
T = sprintf('4Pixel-PSNR %3g dB', PSNR5);
imshow(imgcomp5); title(T);

subplot(422);
T = sprintf('4Pixel-Time %3g', 1.371);
quiver(MVx5, MVy5);title(T);

subplot(423);
T = sprintf('8Pixel-PSNR %3g dB', PSNR6);
imshow(imgcomp6); title(T);

subplot(424);
T = sprintf('8Pixel-Time %3g', 0.432);
quiver(MVx6, MVy6);title(T);

subplot(425);
T = sprintf('16Pixel-PSNR %3g dB', PSNR7);
imshow(imgcomp7); title(T);

subplot(426);
T = sprintf('16Pixel-Time %3g',0.177 );
quiver(MVx7, MVy7);title(T);

subplot(427); 
T = sprintf('32Pixel-PSNR %3g dB', PSNR8);
imshow(imgcomp8); title(T);

subplot(428);
T = sprintf('32Pixel-Time %3g', 0.118);
quiver(MVx8, MVy8);title(T);


figure(5);
title('MotionCompensatedPicture-CSA-ExperimentI-C');
imshow(imgcomp7);

figure(6);
title('MotionVector-CSA-ExperimentI-C')
quiver(MVx7, MVy7);
