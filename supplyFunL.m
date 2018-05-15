function [x, y] = supplyFunL(n,K,Qh,Ql,eh,el)

if (n<0)
    disp('Error: n must be non-negative');
end

% init
x = zeros(1,2*(n+1));
y = x;

gamma = Ql/Qh;
[NnLhh,NnLhl,NnLlh,NnLll] = computeNnL(n+1,K,gamma);
[Jhh,Ihh,Jhl,Ihl,Jlh,Ilh,Ill,Jll] =computeJInL(n+1,K,gamma);

sigmaS = [0 (1:n+1)*Ql - ( eh * NnLlh + el/2*( Jll + NnLll ) )];
sigmaZ = [0 (1:n+1)*Qh + ( eh * NnLhh + el/2*( Ihl + NnLhl ) )];
x(2) = sigmaZ(2);

for i=1:n
    x(2*i+1) = sigmaS(i+1)+sigmaZ(i+1);
    y(2*i+1) = sigmaS(i+1);
    x(2*i+2) = sigmaS(i+1)+sigmaZ(i+2);
    y(2*i+2) = sigmaS(i+1);
end
end
