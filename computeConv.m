function vecN = computeConv(nMax,g)
tfin = length(g);
vecN = zeros(1,nMax);

for i=1:nMax
    gShift = 0*g;
    gShift(i+1:tfin) = g(1:tfin-i);
    rectResp = g-gShift;

    vecN(i) = sum(abs(rectResp));
end