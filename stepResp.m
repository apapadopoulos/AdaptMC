function [yhh,yhl,ylh,yll] = stepResp(K,gamma,tfin)
% Step response

Khh = K(1,1);
Khl = K(1,2);
Klh = K(2,1);
Kll = K(2,2);

% System matrices
A = [zeros(2,2),      eye(2)       ;
     -Khh, -Khl/gamma,1,          0;
     0,    -Kll,      -gamma*Klh, 1];
B = [eye(2);
     zeros(1,2);
     -gamma*Khl,0];
C = [eye(2,2),zeros(2,2)];
D = zeros(size(C,1),size(B,2));
sys = ss(A,B,C,D,-1);
y = step(sys,tfin);

yhh = y(:,1,1);
yhl = y(:,1,2);
ylh = y(:,2,1);
yll = y(:,2,2);
