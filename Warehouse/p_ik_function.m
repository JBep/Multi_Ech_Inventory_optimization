function [p_ik] = p_ik_function(item,ret_vec)
%P_ik_function evaluates the probability of a certain demand at the retailers for the CW lead time.
%   Implementation of equation 10 in the report.

mean = dlmread('Data/mean_item_'+string(item)+'.txt');
Q = dlmread('Data/Q_item_'+string(item)+'.txt');
stdev_mat = dlmread('Data/stdev.txt');
stdev = stdev_mat(:,item);
L0 = dlmread('Data/L_cw.txt');

mean_L0 = mean(1:ret_vec(item)) .* L0(item);
stdev_L0 = stdev(1:ret_vec(item)) .* sqrt(L0(item));

p_ik = zeros(100,ret_vec(item)+1);

k = -20;
i = 1;
cumulative = 0;
tol = 10^-6;

while cumulative < ret_vec(item)-tol  

term_1 = G_function(((k-1).*Q-mean_L0)./stdev_L0);
term_2 = G_function(((k+1).*Q-mean_L0)./stdev_L0);
term_3 = 2.*G_function((k.*Q-mean_L0)./stdev_L0);

p_ik(i,1) = k;
p_ik(i,2:end) = (stdev_L0./Q)'.*(term_1+term_2-term_3)';

cumulative = cumulative + sum(p_ik(i,:));

k = k+1;
i = i+1;
end


end

