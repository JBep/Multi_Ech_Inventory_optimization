function [S2_matrix,E_IL_plus_matrix] = calculate_all(R_matrix,W_matrix,no_retailers_vec)
%calculate_all gives S2 and E_IL_plus for all retailers for a given R_matrix and given W_matrix.
%   Used when calculating the fill rate and other metrics for all items and
%   retailers under the current (R,Q)-policy.


S2_matrix = zeros(5,5);
E_IL_plus_matrix = zeros(5,5);
ret_no = dlmread('Data/no_of_retailers.txt');

% Optimizes each item, it doesn't matter that the w vector picked outo
    % f the matrix has some zeroes at the end.
for item = 1:5  
    [S2_matrix(1:no_retailers_vec(item),item),E_IL_plus_matrix(1:no_retailers_vec(item),item)] ...
        = service_item(item,W_matrix(:,item),R_matrix(:,item),ret_no(item));
end
end

