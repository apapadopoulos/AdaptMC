function [vQ,vS,ve,vQb] = PPA_sim(Qbar, Tfin,scenario)

Qhbar = Qbar(1);
Qlbar = Qbar(2);
P = Qhbar + Qlbar;

% Initialization values
Qh = Qhbar;  % HI-Crit tentative budget
Sh = Qhbar;  % HI-Crit actual budget
Ql = Qlbar;  % LO-Crit tentative budget
Sl = Qlbar;  % LO-Crit actual budget

% Auxiliary vectors for storing the evolution
vQ = zeros(2,Tfin+1);
vS = zeros(2,Tfin+1);
vu = zeros(2,Tfin+1);
ve = zeros(2,Tfin+1);
vQb= [Qhbar;Qlbar].*ones(2,Tfin+1);
e = zeros(2,1);

vQ(:,1) = [Qh;Ql];
vS(:,1) = [Sh;Sl];
ve(:,1) = e;

% Simulation starts
for i = 2:Tfin+1
    t = i - 1;
    if scenario == 0
        % Impulse disturbance
        e(1) = imp(t-10);
        e(2) = -imp(t-50);
    elseif scenario == 1
        % Step disturbance
        e(1) = stp(t-10);
        e(2) = -stp(t-50);
    elseif scenario == 2
        e(1) = min(0.1*ram(t-10),1);
        e(2) = -min(0.1*ram(t-50),1);
    elseif scenario == 3
        % Combination        
        e(1) = imp(t-10) + 0.1*ram(t-60) * (stp(t-60) -stp(t-80));
        e(2) = -stp(t-40);
    elseif scenario == 4
        e(1) = imp(t-10) + stp(t-30) - stp(t-50) + min(0.2*ram(t-65),3);
        e(2) = 0;%-2*imp(t-40);
    else
        % Continuous change
        if t ==10
            e(1) = 1;
            e(2) = -1;
        else
            e(1) = -e(1);
            if t >= 10
                e(2) = min((-1)^(t+1),0);
            end
        end
    end
    
    ve(:,i) = e;
    eh = e(1);
    el = e(2);
    
    Sh = Qh + eh;
    Ql = P - Sh;
    Sl = Ql + el;
    if Sh + Sl > P
        Sl = P-Sh;
    end
    
    vQ(:,i) = [Qh;Ql];
    vS(:,i) = [Sh;Sl];
end
