function [PDF] = poisson_pdf(lambda,t,tolerance)
%poisson_pdf gives the vector of poisson probabilities truncated with tolerance tolerance.

PDF = 0;
test = 1;
k = 0;

while test > tolerance
    % We have to use k+1 as vectors in matlab start from index 1, not 0.
    PDF(k+1) = ((lambda*t).^k)./factorial(k).*exp(-lambda*t);
    test = test - PDF(end); 
    k = k+1;
end
end
