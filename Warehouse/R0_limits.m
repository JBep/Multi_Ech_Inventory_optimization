function [R0_lims] = R0_limits(item)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Q_vec = dlmread('Data/Q_cw.txt');
R = Q_vec(item);

tol = 10^-3;
E_W = 1;
while E_W > tol
    [~,E_W] = central_warehouse_stats(item,R);
    R = R+1;
end

R0_lims = [-Q_vec(item),R];
end

