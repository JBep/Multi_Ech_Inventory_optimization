function [R,S2,E_IL_plus] = optimizing_R_item(item, W_vec,use_lower_lims)
%optimizing_R_retailer This function optimizes R for all the retailers for a given item and waiting time vector.
%   Uses the optimizing_R_retailer.

no_ret_vec = dlmread('Data/no_of_retailers.txt');

if use_lower_lims == 1
    lower_temp_mat = dlmread('Data/lower_lims.txt');
    R_lower_vec = lower_temp_mat(:,item);
else 
    R_lower_vec = dlmread('Data/Q_item_'+string(item)+'.txt');
end


S2_target_vec = dlmread('Data/S2_target_item_'+string(item)+'.txt');

R = zeros(no_ret_vec(item),1);
S2 = zeros(no_ret_vec(item),1);
E_IL_plus = zeros(no_ret_vec(item),1);

for i = 1:no_ret_vec(item)
    [R(i),S2(i),P_IL] = optimizing_R_retailer(item,i,W_vec(i),R_lower_vec(i),S2_target_vec(i));
    E_IL_plus(i)=find_E_IL_plus(P_IL);
end

end

