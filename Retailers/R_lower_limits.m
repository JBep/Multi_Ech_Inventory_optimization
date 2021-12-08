function lim_lower = R_lower_limits(no_retailers_vec)
%R_limits_retailer Find the limits for a single retailer for a specified item.
%   W_worst_vec is a matrix containing the worst possible average waiting time for
%   each item
lim_lower = zeros(5,5);

for item = 1:5
    lim_lower(1:no_retailers_vec(item),item) = optimizing_R_item(item,zeros(5,1),0);
end
end

