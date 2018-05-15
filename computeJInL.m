function [Jhh,Ihh,Jhl,Ihl,Jlh,Ilh,Jll,Ill] =computeJInL(nMax,K,gamma)

tfin = 1e4*nMax; % here we set the horizon of of the summation

% Compute the step response
[rhh,rhl,rlh,rll] = rampResp(K,gamma,tfin);

% Compute the sup of r(k) - r(k-n)
[Jhh,Ihh] = computeJI(nMax,rhh);
[Jhl,Ihl] = computeJI(nMax,rhl);
[Jlh,Ilh] = computeJI(nMax,rlh);
[Jll,Ill] = computeJI(nMax,rll);
