# AdaptMC

## Generate Figure 2
The generation of Figure 2 requires the execution of the following code, contained in the `stability.m` file. 

```matlab
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
```

The variable `C` contains the coefficients "of interest", i.e., the entries of the first column with uneven row-indices. `J` contains the whole Jury chart.

>**Theoreom**
>The eigenvalues of the matrix `A` lie in the unit circle if and only if the coefficients in `C` are greater than zero. Moreover, if non of these is zero, then the number of negative entries gives the number of roots outside the unit disc.


The `jury.m` function is not part of the standard library of Matlab, or of the Control System Toolbox, but it can be found at [this link](https://se.mathworks.com/matlabcentral/fileexchange/13904-jury).

Plugging the coefficients of `C` in a symbolic manipulation tool, allow the calculation. In order to obtain Figure 2, we used Wolfram Mathematica, but a Computable Document Format is also provided.