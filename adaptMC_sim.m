function [vQ,vS,vu,ve,vQb] = adaptMC_sim(K, Qbar, Tfin,scenario)

% Storing the gains
Khh = K(1,1);
Khl = K(1,2);
Klh = K(2,1);
Kll = K(2,2);
Qhbar = Qbar(1);
Qlbar = Qbar(2);

% Initialization values
Qh = Qhbar;  % HI-Crit tentative budget
Sh = Qhbar;  % HI-Crit actual budget
Ql = Qlbar;  % LO-Crit tentative budget
Sl = Qlbar;  % LO-Crit actual budget

Sh_old = Sh; % HI-Crit actual budget old
Sl_old = Sl; % LO-Crit actual budget old

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
    
    Sh = Qh + e(1);
    Sl = Ql + e(2);
    uh = Khh * (Qhbar - Sh_old) + Khl * (Qlbar - Sl_old);
    ul = Klh * (Qhbar - Sh) + Kll * (Qlbar - Sl_old);
    Qh = Qh + uh;
    Ql = Ql + ul;
    
    Sh_old = Sh;
    Sl_old = Sl;
    vQ(:,i) = [Qh;Ql];
    vS(:,i) = [Sh;Sl];
    vu(:,i) = [uh;ul];
end
