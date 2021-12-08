function [E_IL_plus,E_W,E_I0_minus] = central_warehouse_stats(item,R)
%centra_warehouse_stats returns the stock on hand, average waiting time as
%calculated by Axsäters method described in section 2.4 in the report.

q = 1; % This is true for all our items.
Q_cw = dlmread('Data/Q_cw.txt');
Q0 = Q_cw(item);

leadtimes = dlmread('Data/L_cw.txt');
L0 = leadtimes(item);

mean = dlmread('Data/mean_item_' + string(item) +'.txt');
mu_w_daily = sum(mean);
mu_w_L0 = mu_w_daily.*L0; 

variance_vec = variance_retailers_at_CW(item);

sigma_w = sqrt(sum(variance_vec));

H_1 = H_function((R+q-mu_w_L0)./sigma_w);
H_2 = H_function((R+Q0-mu_w_L0)./sigma_w);

E_I0_minus = (sigma_w.^2./(Q0-q)).*(H_1-H_2);

E_W = E_I0_minus/mu_w_daily;

E_IL_plus = R+(Q0+q)/2-mu_w_L0+E_I0_minus;


end

