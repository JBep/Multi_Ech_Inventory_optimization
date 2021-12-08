function [S2,P_IL] = serv_levels_continuous(R,Q,f,PDF_D)
%serv_levels_continous calculates the S2 and S3 service levels for the given inputs.
%   R and Q are from the (R,Q)-policy. f holds the demand distribution
%   given one customer. PDF_D hold the demand probabilities for the coumpound poisson distributed demand.


% Implementation of equation 5.
P_IL = zeros(1,R+Q); % Saving probabilities for j = 1 until j = R+Q.

for j = 1:R+Q
    for k = max(R+1,j):R+Q    % Summarizing over all possible values of IP.
        P_IL(j) = P_IL(j) + PDF_D(k-j+1); % As index 1 holds the probability of demand = 0 we need to shift the indexes one step.
    end
end
P_IL = P_IL/Q;


% Implementation of equation 4.
sum_numerator = 0;
sum_denominator = 0;

for k = 1:length(f)
    for j = 1:R+Q
        sum_numerator = sum_numerator + min(j,k)*f(k)*P_IL(j); 
    end
    sum_denominator = sum_denominator + k*f(k);
end

S2 = sum_numerator/sum_denominator;

end

