clear; clc;

SAVE = 1;
SCENARIO = 1;
fontSize = 16;

%% Definition of quantities
% Desired budgets
Qhbar = 10;  % HI-Crit desired budget
Qlbar = 8;   % LO-Crit desired budget

%% Different gains
figure(6); clf;

for gain = 1:5
    
    if gain == 1
        % K1
        Khh = 0.4;
        Khl = 0.1;
        Klh = 0.1;
        Kll = 0.35;
    elseif gain == 2
        % K2
        Khh = 0.15;
        Khl = 0.1;
        Klh = 0.1;
        Kll = 0.15;
    elseif gain == 3
        % K3
        Khh = 0.25;
        Khl = 0.1;
        Klh = 0.1;
        Kll = 0.25;
    elseif gain == 4
        % K4
        Khh = 0.5;
        Khl = 0.1;
        Klh = 0.1;
        Kll = 0.5;
    elseif gain == 5
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
    
    % Simulation
    Tfin = 100;           % Final time of the simulation
    time = 0:Tfin;
    Qbar = [Qhbar;Qlbar];
    [vQ,vS,vu,ve,vQb] = adaptMC_sim(K,Qbar,Tfin,SCENARIO);
    
    if gain == 1
        subplot(311); hold on;
        stairs(time,ve(1,:),'LineWidth',2);
        stairs(time,ve(2,:),'LineWidth',2);
        xlabel('time','FontSize',fontSize);
        ylabel('\epsilon','FontSize',fontSize);
        h311 = legend('\epsilon_H','\epsilon_L');
    end
    
    
    subplot(312); hold on;
    %if gain==1
    %    plot(time,vQb(1,:),'k--');
    %end
    stairs(time,vS(1,:),'LineWidth',2);
    xlabel('time','FontSize',fontSize);
    ylabel('S_H','FontSize',fontSize);
    
    subplot(313);  hold on;
    stairs(time,vS(2,:),'LineWidth',2);
    %if gain==1
    %     plot(time,vQb(2,:),'k--');
    %end
    xlabel('time','FontSize',fontSize);
    ylabel('S_L','FontSize',fontSize);
    
    if SAVE
        head = {'time','eH','eL','SH','SL','QH','QL'};
        M = [time',ve',vS',vQ'];
        filename = sprintf('step_%d.csv',gain);
        csvwrite_with_headers(filename,M,head);
    end
    
end

subplot(312);
legend('K_1','K_2','K_3','K_4','K_5');

subplot(313);
legend('K_1','K_2','K_3','K_4','K_5');
