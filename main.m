%% Main

% Calculating the limits for reorder points R0 for all items as described
% in section 2.5.1 in the report.
limits = zeros(2,5);
for item = 1:5
    limits(:,item) = R0_limits(item)';
end

%% Produce solution for the specified item.
% producing the solution for one item at a time. The matrix holds all
% tested combinations. The min_index is where the optimal solution is found
% in the matrix. 

% Experimental: [Put the third parameter to true and the faster, but experimental, method of
% finding the optimal solution as described in section 4.3.2 is used. Disclaimer: Mainly tested for item 1.]

% FYI: Item 1 is the slowest, try item 2 or 5 if you want to test the code
% but don't want to wait a couple of minutes.

% Put item as 1,2,3,4 or 5.
item = 5;

[mat,min_index]=optimizing_system(item,limits(:,item),false);


%% Calculating model stock on hand and fillrates given current reorder points.
% The values in this part was calculated in order to evaluate the
% performance of the model given the current reorder points as to analyse
% the accuracy of the estimations before implementing the optimization
% algorithm.

res_matrix = zeros(5,18);

R0 = dlmread('Data/R_cw.txt');
W_matrix = zeros(5,5);

res_matrix(:,1) = R0;

for item = 1:5
    [res_matrix(item,2),res_matrix(item,3)] =central_warehouse_stats(item,R0(item)); 
    W_matrix(:,item) = ones(5,1)*E_W;
end

no_ret = dlmread('Data/no_of_retailers.txt');
R_retailers = dlmread('Data/R_values.txt');

res_matrix(:,4:8) = R_retailers;

[res_matrix(:,9:13),res_matrix(:,14:18)] = calculate_all(R_retailers,W_matrix,no_ret);

