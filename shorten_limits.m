function new_lims = shorten_limits(item,cw_R_limits,panels, max_lim)
%shorten_limits is a recursive function to improve the optimization algorithm as suggested in the analysis section of the report.
%   panels is the amount of new intervals the interval is split into, experimentation showed that values between 5-8 worked okay.
%   max_lim is the maximum interval on which to check all R, experimentation showed that somewhere
%   between 40-80 worked fine.
%
%   Disclaimer: Experimental, only really tested for item 1.


no_ret = dlmread('Data/no_of_retailers.txt');

total_R = cw_R_limits(2)-cw_R_limits(1)+1;
jump = floor(total_R/panels);
cw_R_limits_first = zeros(panels+1,1);

lower_R = cw_R_limits(1);
upper_R = cw_R_limits(2);

for i = 1:panels
    cw_R_limits_first(i) = lower_R + (i-1).*jump;
end
cw_R_limits_first(i+1) = upper_R;

result_mat = zeros(panels+1,2);

for i = 1:length(cw_R_limits_first)
    r = cw_R_limits_first(i);
    [E_IL_plus_cw,E_W] = central_warehouse_stats(item,r);
    W_vec = ones(1,no_ret(item)).*E_W;
    [~,~,E_IL_plus_ret] = optimizing_R_item(item,W_vec,true);
    
    result_mat(i,:) = [r, (E_IL_plus_cw + sum(E_IL_plus_ret))];

end


% finding smallest value
min = result_mat(1,2);
min_index = 1;
for index = 2:panels + 1
    value = result_mat(index,2);
    
    if value < min
        min = value;
        min_index = index;
    end
end

if min_index == 1
    new_lims = [1,1+jump];
elseif min_index == panels + 2
    new_lims = [lower_R+jump.*(panels+1),upper_R];
else 
    if result_mat(min_index-1,2) < result_mat(min_index+1,2)
        new_lims = [result_mat(min_index-2,1), result_mat(min_index+1,1)];
    else
        new_lims = [result_mat(min_index-1,1), result_mat(min_index+2,1)];
    end
end

if (new_lims(2)-new_lims(1)+1>max_lim)
    new_lims = shorten_limits(item,new_lims,panels,max_lim);

end

