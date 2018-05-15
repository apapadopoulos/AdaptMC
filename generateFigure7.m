clear; clc;
SAVE = 1;  % Save csv file with data

GAIN = 1;
SCENARIO = 1;

%% Definition of quantities
% Desired budgets
Qhbar = 10;  % HI-Crit desired budget
Qlbar = 8;   % LO-Crit desired budget

%% Different gains
if GAIN == 1
    % K1
    Khh = 0.4;
    Khl = 0.1;
    Klh = 0.1;
    Kll = 0.35;
elseif GAIN == 2
    % K2
    Khh = 0.15;
    Khl = 0.1;
    Klh = 0.1;
    Kll = 0.15;
elseif GAIN == 3
    % K3
    Khh = 0.25;
    Khl = 0.1;
    Klh = 0.1;
    Kll = 0.25;
elseif GAIN == 4
    % K4
    Khh = 0.5;
    Khl = 0.1;
    Klh = 0.1;
    Kll = 0.5;
elseif GAIN == 5
    % K5
    Khh = 0.75;
    Khl = 0.1;
    Klh = 0.1;
    Kll = 0.75;
else
    % Custom gain
    Khh = 0.9;
    Khl = 0;
    Klh = 0;
    Kll = 0.1;
end
K = [Khh,Khl;
    Klh,Kll];

%% Cmputation of the eigenvalues of the closed-loop system
A = [zeros(2,2),  eye(2);
     -Khh, -Khl,    1, 0;
        0, -Kll, -Klh, 1];

fprintf('\n');
fprintf('*******************************************\n');
fprintf('* Stability check                         *\n');
fprintf('*******************************************\n');
fprintf('\nMagnitude of the closed-loop eigenvalues:\n');
fprintf('|lambda1| = %g\n|lambda2| = %g\n|lambda3| = %g \n|lambda4| = %g\n',abs(eig(A)));
fprintf('Asymptotic stability for all |lambda| < 1\n');
fprintf('*******************************************\n');
%% Simulation 
Tfin = 100;           % Final time of the simulation
Qbar = [Qhbar;Qlbar];
[vQ,vS,vu,ve,vQb] = adaptMC_sim(K,Qbar,Tfin,SCENARIO);
[vQ_alt,vS_alt,ve_alt,vQb_alt] = PPA_sim(Qbar, Tfin,SCENARIO);

%% Plotting results
time = 0:Tfin;
plottingResults_comparison(time,vQ,vS,ve,vQb,vQ_alt,vS_alt,ve_alt,vQb_alt);

%% Saving CSV
if SAVE
    head = {'time','eH','eL','SH','SL','QH','QL'};
    M = [time',ve',vS',vQ'];
    csvwrite_with_headers('adaptMC.csv',M,head);
    
    M_alt = [time',ve_alt',vS_alt',vQ_alt'];
    csvwrite_with_headers('PPA.csv',M_alt,head);
end