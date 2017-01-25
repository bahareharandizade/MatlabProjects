


function  [imgcomp,MVx,MVy,PSNR]=MotionEstimEBMA(mbSize, p,imgI,imgP)


imgP1 = imgP;
M        = floor(size(imgI, 1)/mbSize)*mbSize;
N        = floor(size(imgI, 2)/mbSize)*mbSize;
imgI  = imgI(1:M, 1:N);
imgP = imgP(1:M, 1:N);
imgI  = padarray(imgI,  [mbSize/2 mbSize/2], 'replicate');
imgP = padarray(imgP, [mbSize/2 mbSize/2], 'replicate');

imgI  = padarray(imgI,  [p, p]);
imgP = padarray(imgP, [p, p]);


[M,N] = size(imgI);
imgcomp=zeros(M,N);
L           = floor(mbSize/2);
BlockRange  = -L:L-1;
xc_range    = p+L+1 : mbSize : N-(p+L);
yc_range    = p+L+1 : mbSize : M-(p+L);

MVx = zeros(length(yc_range), length(xc_range));
MVy = zeros(length(yc_range), length(xc_range));

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
               
                
                 RefBlock=imgI(yt+BlockRange,xt+BlockRange);
                 SAD =sum(abs(CurBlock(:) -RefBlock(:) ))/(mbSize^2);
        
               if SAD < SADmin
               SADmin  = SAD;
               x_min   = xt;
               y_min   = yt;
               end     
                
            end
        end
        
        MVx(i,j) =x_min-xc;    
        MVy(i,j) =y_min-yc;   
        
        
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
        RefBlock=imgI(yt+BlockRange,xt+BlockRange);
        imgcomp(yc+BlockRange, xc+BlockRange)= RefBlock;
    end
end
imgcomp=imgcomp(p+L+1:M-(p+L), p+L+1 : N-(p+L));
PSNR=imgPSNR(imgP1,imgcomp);


function PSNR = imgPSNR(imgP, imgComp)
[M ,N] = size(imgComp);
Res=imgComp-imgP(1:M,1:N);
MSE  = norm(Res(:), 'fro')^2/numel(imgComp);
PSNR = 10*log10(max(imgComp(:))^2/MSE);
