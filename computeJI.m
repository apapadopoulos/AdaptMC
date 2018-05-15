function [J,I] = computeJI(nMax,g)
tfin = length(g);
J = zeros(1,nMax);
I = zeros(1,nMax);

for i=1:nMax
    gShift = 0*g;
    gShift(i+1:tfin) = g(1:tfin-i);
    rectResp = g-gShift;

    J(i) = max(rectResp);
    I(i) = -min(rectResp);
end