clear; clc;
% Definition of symbolic variables
syms Khh Khl Kll Klh real
syms z

% Dynamic matrix of AdaptMC
A = [zeros(2,2), eye(2);
     -Khh, -Khl,   1, 0;
        0, -Kll,-Klh, 1];
 
% Computation of the characteristic polynomial
p = charpoly(A,z);

% Extraction of the coefficient of the characteristic polynomial
c1 = coeffs(p,z);
c2 = c1(end:-1:1);  % Reordering the coefficients

% Computation of the Jury chart
[J,C] = jury(c2)