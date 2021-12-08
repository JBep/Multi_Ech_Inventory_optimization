function [result_matrix,min_row_index] = optimizing_system(item,cw_R_limits,faster)
%Optimizing_system optimizes the system with the algorithm suggested in the
%method section.
%   if faster == true then the shorten_limits function is used to try to
%   improve the efficiency of the optimization, use with caution!

if faster == 1
    new_lims = shorten_limits(item,cw_R_limits,5,60);
else
    new_lims = cw_R_limits;
end

no_ret = dlmread('Data/no_of_retailers.txt');
        
result_matrix = zeros(new_lims(2)-new_lims(1)+1,3+no_ret(item).*3);
i = 1;
for r = new_lims(1):new_lims(2)
    [E_IL_plus_cw,E_W] = central_warehouse_stats(item,r);
    W_vec = ones(1,no_ret(item)).*E_W;
    [R,S2,E_IL_plus_ret] = optimizing_R_item(item,W_vec,true);
    
    result_matrix(i,:) = [r, R',S2',E_IL_plus_cw,E_IL_plus_ret', (E_IL_plus_cw + sum(E_IL_plus_ret))];
    i = i+1;
end

[~,cols] = size(result_matrix);
min = result_matrix(1,cols);
min_row_index = 1;
for index = 2:length(result_matrix);
    value = result_matrix(index,cols);
    
    if value < min
        min = value;
        min_row_index = index;
    end
end

result_matrix(min_row_index,:)

end

