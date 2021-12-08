function [S2,E_IL_plus] = service_item(item,W_vec,R_vec,ret_no)
%service_item calculates the S2 and E_IL_plus for a specific item.
% 

S2 = zeros(ret_no,1);
E_IL_plus = zeros(ret_no,1);

for i = 1:ret_no
    [S2(i),P_IL] = service_retailer(item,i,W_vec(i),R_vec(i));
    E_IL_plus(i)=find_E_IL_plus(P_IL);
end

end

