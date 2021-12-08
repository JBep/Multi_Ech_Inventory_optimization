function [S2,P_IL] = service_retailer(item,retailer,W,R)
%service_retailer returns S2 for a specific retailer for a specified item using compound
%poisson distribution and METRIC approximation approach adding the waiting
%time W to the lead time L.
%   item is an item number between 1-5.
%   W is the average waiting time at the warehouse
%   retailer is the retailers number.
%   S2 are a column vectors.


% Retrieveing specific information, retailer no is the order of the
% retailers in the excel file. (for item 1, retailer 7 is number 1,
% retailer 19 has number 2 and so on.
[mean,f_matrix,L,Q] = retrieve_information(item,retailer);

% Adding W
L = L+W;

% Finding E[J]
E_J = 0;

for i = 1:max(f_matrix(:,1))
        E_J = E_J + f_matrix(i,1).*f_matrix(i,2);
end


lambda = mean/E_J;
tol = 10^-6;

[S2,P_IL] = service_compound_poisson(lambda,L,tol,f_matrix,R,Q);

end
