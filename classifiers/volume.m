function [ v ] = volume( x )

n=length(x);

v=(pi^(n/2))/gamma(n/2+1)*norm(x,2)^n;

end

