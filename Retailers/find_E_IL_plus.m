function [E_IL_plus] = find_E_IL_plus(P_IL)
%E_IL_plus calculates expected stock on hand, P_IL vector hold
%probabilities from inventory level i=1 til maximum inventory level.
%   implementation of equation 3.
E_IL_plus = 0;

for i = 1:length(P_IL)
   E_IL_plus = E_IL_plus + i*P_IL(i); 
end
end

