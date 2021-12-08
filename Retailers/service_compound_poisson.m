function [S2,P_IL] = service_compound_poisson(lambda,L,tol,f_matrix,R,Q)
%service_compound_poisson Calculates the service rates and PDF-function for positive
%inventory levels for an inventory location under the assumption of poisson
%compound customer demand.
%
%   Lambda is the customer arrival rate.
%   L is the leadtime.
%   tol is the trunctation tolerance on the customer arrival poisson
%   probability.
%   f_vector is a column matrix with the order quantities in column 1 and
%   probabilities in column 2.

K_vec = poisson_pdf(lambda,L,tol);

kmax = length(K_vec)-1; 
jmax = max(f_matrix(:,1)).*kmax; 

f = zeros(jmax,kmax); % Probabilities stored in a matrix. 

% Probabilities for one customer demand given.
for i = 1:length(f_matrix(:,1))
    f(f_matrix(i,1),1) = f_matrix(i,2);
end


% Calculating the double sum recursively for each j and k in equation 9. 
% Starting recursion from 2 as the distribution for one customer is already given. 
for k = 2:kmax                 
    for j = 1:jmax
        for i = k-1:j-1
            f(j,k) = f(j,k)+f(i,k-1)*f(j-i,1);
        end
    end
end

PDF_d = zeros(jmax+1,1);
PDF_d(1) = K_vec(1);

for i = 2:jmax+1
    for j = 2:kmax+1
        PDF_d(i) = PDF_d(i) + f(i-1,j-1)*K_vec(j);
    end
end


[S2,P_IL] = serv_levels_continuous(R,Q,f(:,1),PDF_d);


end

