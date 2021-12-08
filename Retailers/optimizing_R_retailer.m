function [R,S2,P_IL] = optimizing_R_retailer(item,retailer,W,R_lower,S2_target)
%optimizing_R  This function optimizes R for a given item and retailer for a given waiting time W. 
%   Q and S2_target is given as inputs. Implementation of the algorithm
%   described in section 2.5.3.

S2 = 0;
R = R_lower-1;

while S2 < S2_target
    R = R+1;
    [S2,P_IL] = service_retailer(item,retailer,W,R);
end
end

