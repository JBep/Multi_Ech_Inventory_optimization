function g_out = G_function(y)
%G_function

g_out = normpdf(y)-y.*(1-normcdf(y));

end

