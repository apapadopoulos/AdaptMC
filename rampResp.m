function [yhh,yhl,ylh,yll] = rampResp(K,gamma,tfin)
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
z = tf('z',-1);
sys2 = series(1/(z-1),sys);
y = step(sys2,tfin);

yhh = y(:,1,1);
yhl = y(:,1,2);
ylh = y(:,2,1);
yll = y(:,2,2);
