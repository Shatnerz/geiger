function [poisson]=poisspdf(x,lambda)

i=length(x)
for j=1:i

poisson(j)=lambda^x(j)/factorial(x(j))*exp(-lambda)

end
