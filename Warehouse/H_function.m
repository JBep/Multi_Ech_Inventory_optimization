function h_out = H_function(y)
%H_function 

h_out = (1/2)*(((y.^2+1).*(1-normcdf(y))-y.*normpdf(y)));

end

