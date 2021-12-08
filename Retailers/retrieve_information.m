function [mean,f_matrix,leadtime,order_quantity] = retrieve_information(item,retailer)
%retrieve_information gives the information for a specified item for a
%specific retailer, the variable retailer takes the order of the retailer
%in excel, and not the actual retailer number.
%   Detailed explanation goes here


f = dlmread('Data/f_item_'+string(item)+'.txt');
m = dlmread('Data/mean_item_'+string(item)+'.txt');
L = dlmread('Data/L_item_'+string(item)+'.txt');
Q = dlmread('Data/Q_item_'+string(item)+'.txt');


f_matrix = [f(:,1),f(:,1+retailer)];
mean = m(retailer);
leadtime = L(retailer);
order_quantity = Q(retailer);


end

