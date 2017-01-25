function bidirectional()
img1 = im2double(rgb2gray(imread('Reference/2/F1.BMP')));
img2 = im2double(rgb2gray(imread('Reference/2/F2.BMP')));
img3 = im2double(rgb2gray(imread('Reference/2/F3.BMP')));


[imgcomp2,MVx2,MVy2,PSNR2]=MotionEstimEBMA(8,16,img1,img3);%motion compensate frame3
[imgcomp3,MVx3,MVy3,PSNR3]=bidirectionalFSM(8,16,img1,imgcomp2,img2);%motion compensate frame 2 ref to frame 1 and motion compensate frame3

[imgcomp4,MV4,MV4,PSNR4]=MotionEstimEBMA(8,16,img3,img2);%motion compensate frame 2 ref to frame 3
[imgcomp5,MV5,MV5,PSNR5]=MotionEstimEBMA(8,16,img1,img2);%motion compensate frame 2 ref to frame 1

[imgcomp6,MVx6,MVy6,PSNR2]=LogSearch(8,16,img1,img3);
[imgcomp7,MVx7,MVy7,PSNR7]=bidirectionalCSA(8,16,img1,imgcomp2,img2);

[imgcomp8,MV8,MV8,PSNR8]=LogSearch(8,16,img3,img2);
[imgcomp9,MV9,MV9,PSNR9]=LogSearch(8,16,img1,img2);


figure(1);
subplot(221);
T = sprintf('Image2');
imshow(img2); title(T);

 subplot(222);
 T = sprintf('frame 2 ref to frame 1 and motion compensate frame 3-PSNR %3g dB', PSNR3);
imshow(imgcomp3); title(T); 

subplot(223);
 T = sprintf('motion Compensate frame 2 ref to frame 3-PSNR %3g dB', PSNR4);
imshow(imgcomp4); title(T);

subplot(224);
 T = sprintf('motion Compensate frame 2 ref to frame 1-PSNR %3g dB', PSNR5);
imshow(imgcomp5); title(T);


figure(2);
subplot(221);
T = sprintf('Image2');
imshow(img2); title(T);

 subplot(222);
 T = sprintf('frame 2 ref to frame 1 and motion compensate frame 3-PSNR %3g dB', PSNR7);
imshow(imgcomp7); title(T); 

subplot(223);
 T = sprintf('motion Compensate frame 2 ref to frame 3-PSNR %3g dB', PSNR8);
imshow(imgcomp8); title(T);

subplot(224);
 T = sprintf('motion Compensate frame 2 ref to frame 1-PSNR %3g dB', PSNR9);
imshow(imgcomp9); title(T);
