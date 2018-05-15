function plottingResults_comparison(time,vQ,vS,ve,vQb,vQ_alt,vS_alt,ve_alt,vQb_alt,SAVE_FIG)

fontSize = 16;

figure(7); clf;
subplot(421); hold all;
stairs(time,ve(1,:),'LineWidth',2);
stairs(time,ve(2,:),'LineWidth',2);
xlabel('time','FontSize',fontSize);
ylabel('\epsilon','FontSize',fontSize);
h311 = legend('\epsilon_H','\epsilon_L');
set(h311,'FontSize',fontSize);

subplot(423); hold all;
stairs(time,vS(1,:),'LineWidth',2);
stairs(time,vS(2,:),'LineWidth',2);
plot(time,vQb,'k--');
xlabel('time','FontSize',fontSize);
ylabel('S','FontSize',fontSize);
h312=legend('S_H','S_L');
set(h312,'FontSize',fontSize);

subplot(425); hold all;
stairs(time,vQ(1,:),'LineWidth',2);
stairs(time,vQ(2,:),'LineWidth',2);
xlabel('time','FontSize',fontSize);
ylabel('Q','FontSize',fontSize);
h313 = legend('Q_H','Q_L');
set(h313,'FontSize',fontSize);

subplot(427); hold all;
stairs(time,vS(2,:)./vS(1,:),'LineWidth',2);
stairs(time,vQb(2,:)./vQb(1,:),'k--');
ylabel('S_L/S_H','FontSize',fontSize);
xlabel('time','FontSize',fontSize);


%% PPA approach
subplot(422); hold all;
stairs(time,ve_alt(1,:),'LineWidth',2);
stairs(time,ve_alt(2,:),'LineWidth',2);
xlabel('time','FontSize',fontSize);
ylabel('\epsilon','FontSize',fontSize);
h311 = legend('\epsilon_H','\epsilon_L');
set(h311,'FontSize',fontSize);

subplot(424); hold all;
stairs(time,vS_alt(1,:),'LineWidth',2);
stairs(time,vS_alt(2,:),'LineWidth',2);
plot(time,vQb_alt,'k--');
xlabel('time','FontSize',fontSize);
ylabel('S','FontSize',fontSize);
h312=legend('S_H','S_L');
set(h312,'FontSize',fontSize);

subplot(426); hold all;
stairs(time,vQ_alt(1,:),'LineWidth',2);
stairs(time,vQ_alt(2,:),'LineWidth',2);
xlabel('time','FontSize',fontSize);
ylabel('Q','FontSize',fontSize);
h313 = legend('Q_H','Q_L');
set(h313,'FontSize',fontSize);

subplot(428); hold all;
stairs(time,vS_alt(2,:)./vS_alt(1,:),'LineWidth',2);
stairs(time,vQb_alt(2,:)./vQb_alt(1,:),'k--');
ylabel('S_L/S_H','FontSize',fontSize);
xlabel('time','FontSize',fontSize);

%% Saving figure
SAVE_FIG = 0
if SAVE_FIG
    print('figure7','-dpdf');
end
