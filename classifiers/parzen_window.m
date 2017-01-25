function [ y ] = parzen_window( x )

y=0;
if(max(abs(x))<=.5)
    y=1;
end

end

