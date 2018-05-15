%   JURY: Helps you using the JURY-criterion to decide whether or not all
%       roots of a given polynomial lie inside the unit disc.
%
%         [J,C] = jury(coeff);
%         coeff: n-dim vector, either numeric or symbolic.
%         Creates a n x (2n-1) -dim matrix J and a n-dim vector C.
%         If coeff holds the coefficients of a polynomial in say z
%         in descending order, then J is the Jury-Chart of this
%         polynomial and in C are the coefficients "of interest" i.e. 
%         the entries of the first column with uneven row-indices.
%         Please make sure, that you scale the polynomial, so the 
%         coefficient of the biggest power is greater than zero!
%         Then it holds, that all roots of your polynomial lie in the
%         unit circle, if and only if all J(1:2:2*n-1,1) (That is, the entries
%         in the first column in the uneven rows) are greater than zero.
%         Moreover, if none of these is zero, than the number of negative entries
%         gives the number of roots outside the unit disc.
% 
%         EXAMPLE:
% 
%             Let your polynomial be
%                 q(z) = -2*z^2 + z -3
%             then you have to scale it (which does NOT change the roots)
%                 q*(z) = z^2 - z/2 + 1.5
%             the vector is then
%                 coeff = [1 -0.5 1.5]
%             and jury(coeff) gives:
%                   >>jury(coeff)
% 
%                   ans =
%                             1.0000   -0.5000    1.5000
%                             1.5000   -0.5000    1.0000
%                            -1.2500    0.2500         0
%                             0.2500   -1.2500         0
%                            -1.2000         0         0
%
%                 thus, two roots lie outside the unit circle.
%                 Checking them gives
%                    >>roots(coeff)
% 
%                    ans =
%                            0.2500 + 1.1990i
%                            0.2500 - 1.1990i
%                 which indeed lie outside the unit circle.           
%       
%           Author: Jonathan Epperlein
%           E-Mail: Jonathan.Epperlein (at) student.uni-magdeburg.de
%           Version: 0.1
%           Date: Feb. 8, 2007
%           
%           ToDos/ Bugs: Nothing yet, just let me know ;-)
                   


function [J,C] = jury(coeff)


J = [coeff;flipdim(coeff,2)];
typ = class(coeff);
n = length(coeff)-1;

if strcmp(typ,'sym')
    for i=3:2:(2*n+1)
        try
            alph = J(i-1,1)/J(i-2,1);
        catch
            disp('Your polynomial seems to be critical')
            rethrow(lasterror);
            break;
        end
        newrow_1 = J(i-2,:)-alph*J(i-1,:);
        newrow = simplify(newrow_1);
        J = [J ; newrow ; 
                [flipdim(newrow(1:end-(i-1)/2),2) , zeros(1,(i-1)/2)]
                                    ];
    end
else
    for i=3:2:(2*n+1)
        try
            alph = J(i-1,1)/J(i-2,1);
        catch
            disp('Your polynomial seems to be critical')
            rethrow(lasterror);
            break;
        end
        newrow = J(i-2,:)-alph*J(i-1,:);
        J = [J ; newrow ; 
                [flipdim(newrow(1:end-(i-1)/2),2) , zeros(1,(i-1)/2)]
                                    ];
    end
end

J = J(1:end-1,:);
C = J(1:2:end,1);