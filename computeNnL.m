function [vecNhh,vecNhl,vecNlh,vecNll] =computeNnL(nMax,K,gamma)

tfin = 100000*nMax; % here we set the horizon of of the summation

% Compute the step response
[ghh,ghl,glh,gll] = stepResp(K,gamma,tfin);

% Compute the norm1 of g(k) - g(k-n)
vecNhh = computeConv(nMax,ghh);
vecNhl = computeConv(nMax,ghl);
vecNlh = computeConv(nMax,glh);
vecNll = computeConv(nMax,gll);
