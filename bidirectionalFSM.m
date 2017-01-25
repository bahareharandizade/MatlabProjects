


function  [imgcomp,MVx,MVy,PSNR]=bidirectionalFSM(mbSize, p,imgI1,imgI2,imgP)

imgP1 = imgP;
M        = floor(size(imgI1, 1)/mbSize)*mbSize;
N        = floor(size(imgI1, 2)/mbSize)*mbSize;
imgI1  = imgI1(1:M, 1:N);
imgI2  = imgI2(1:M, 1:N);
imgP = imgP(1:M, 1:N);
imgI1  = padarray(imgI1,  [mbSize/2 mbSize/2], 'replicate');
imgI2  = padarray(imgI2,  [mbSize/2 mbSize/2], 'replicate');
imgP = padarray(imgP, [mbSize/2 mbSize/2], 'replicate');

imgI1  = padarray(imgI1,  [p, p]);
imgI2  = padarray(imgI2,  [p, p]);
imgP = padarray(imgP, [p, p]);


[M,N] = size(imgI1);
imgcomp=zeros(M,N);
L           = floor(mbSize/2);
BlockRange  = -L:L-1;
xc_range    = p+L+1 : mbSize : N-(p+L);
yc_range    = p+L+1 : mbSize : M-(p+L);

MVx = zeros(length(yc_range), length(xc_range));
MVy = zeros(length(yc_range), length(xc_range));
direct = zeros(length(yc_range), length(xc_range));
for i = 1 :length(yc_range)
    
    for j = 1 : length(xc_range)
        xc = xc_range(j);
        yc = yc_range(i);
        SADmin      = 1e6;
       CurBlock=imgP(yc+BlockRange, xc+BlockRange);
        for m = -p : p        
            for n = -p : p
                xt = xc + n;   
                yt = yc + m;  
               
                 
                 RefBlock1=imgI1(yt+BlockRange,xt+BlockRange);
                 SAD1 =sum(abs(CurBlock(:) -RefBlock1(:) ))/(mbSize^2);
                 
                 RefBlock2=imgI2(yt+BlockRange,xt+BlockRange);
                 SAD2 =sum(abs(CurBlock(:) -RefBlock2(:) ))/(mbSize^2);
        
               if (SAD1 < SADmin)
               SADmin  = SAD1;
               x_min   = xt;
               y_min   = yt;
               direction=0;
               end
               if(SAD2<SADmin)
               SADmin  = SAD2;
               x_min   = xt;
               y_min   = yt;
               direction=1;
               end
               
               
                
            end
        end
        
        MVx(i,j) =x_min-xc;    
        MVy(i,j) =y_min-yc;
        direct(i,j)=direction;
        
        
    end
end
for i = 1 :length(yc_range)
    
    for j = 1 : length(xc_range)
        xc = xc_range(j);
        yc = yc_range(i);
        dx= MVx(i,j);
        dy=MVy(i,j);
        xt=xc+dx;
        yt=yc+dy;
        if(direct(i,j)==0)
        RefBlock=imgI1(yt+BlockRange,xt+BlockRange);
        imgcomp(yc+BlockRange, xc+BlockRange)= RefBlock;
        else
        RefBlock=imgI2(yt+BlockRange,xt+BlockRange);
        imgcomp(yc+BlockRange, xc+BlockRange)= RefBlock;
        end
    end
end
imgcomp=imgcomp(p+L+1:M-(p+L), p+L+1 : N-(p+L));
PSNR=imgPSNR(imgP1,imgcomp);


function PSNR = imgPSNR(imgP, imgComp)
[M ,N] = size(imgComp);
Res=imgComp-imgP(1:M,1:N);
MSE  = norm(Res(:), 'fro')^2/numel(imgComp);
PSNR = 10*log10(max(imgComp(:))^2/MSE);
