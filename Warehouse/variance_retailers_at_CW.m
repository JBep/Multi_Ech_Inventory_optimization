function variance_vec = variance_retailers_at_CW(item)
%variance_retailers calculates demand variance of retailer demand at warehouse during warehouse leadtime.
%   Implementation of equation 12 in the report.

ret_no_vec = dlmread('Data/no_of_retailers.txt');
p_ik = p_ik_function(item,ret_no_vec);
mean = dlmread('Data/mean_item_'+string(item)+'.txt')';
Q = dlmread('Data/Q_item_'+string(item)+'.txt')';

L0 = dlmread('Data/L_cw.txt');
mean_L0 = mean(1:ret_no_vec(item)) .* L0(item);

ret_no = ret_no_vec(item);

variance_vec = zeros(1,ret_no);

for i = 1:length(p_ik) 
    k_vec = ones(1,ret_no).*p_ik(i,1);
    variance_vec = variance_vec + (k_vec.*Q-mean_L0).^2.*p_ik(i,2:end);
end

end

