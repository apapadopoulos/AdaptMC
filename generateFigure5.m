clear; clc;
SAVE = 0;

%%
Ql=10;      % server period
Qh=8;
eh=1;
el=1;
n=30;

%% K1
fprintf('Processing K1...');
K1 = [0.40,0.1;
      0.1,0.35];
[x1, y1] = supplyFunH(n,K1,Qh,Ql,eh,el);
[xx1, yy1] = supplyFunL(n,K1,Qh,Ql,eh,el);
fprintf('done!\n');

%% K2
fprintf('Processing K2...');
K2 = [0.15,0.10;
      0.10,0.15];
[x2,y2] = supplyFunH(n,K2,Qh,Ql,eh,el);
[xx2,yy2] = supplyFunL(n,K2,Qh,Ql,eh,el);
fprintf('done!\n');

%% K3
fprintf('Processing K3...');
K3 = [0.25,0.10;
      0.10,0.25];
[x3, y3] = supplyFunH(n,K3,Qh,Ql,eh,el);
[xx3, yy3] = supplyFunL(n,K3,Qh,Ql,eh,el);
fprintf('done!\n');

%% K4
fprintf('Processing K4...');
K4 = [0.50,0.10;
      0.10,0.50];
[x4, y4] = supplyFunH(n,K4,Qh,Ql,eh,el);
[xx4, yy4] = supplyFunL(n,K4,Qh,Ql,eh,el);
fprintf('done!\n');

%% K5
fprintf('Processing K5...');
K5 = [0.75,0.10;
      0.10,0.75];
[x5, y5] = supplyFunH(n,K5,Qh,Ql,eh,el);
[xx5, yy5] = supplyFunL(n,K5,Qh,Ql,eh,el);
fprintf('done!\n');

%% Plotting results
figure(1); clf;
subplot(211); hold all;
title('Supply Function -- Hi-Crit')
plot(x1,y1,'k-');
plot(x2,y2,'r-');
plot(x3,y3,'g-');
plot(x4,y4,'b-');
plot(x5,y5,'m-');

ylabel('sbf(t)');
xlabel('t');
legend('K1','K2','K3','K4','K5')
grid on;

subplot(212); hold all;
title('Supply Function -- Lo-Crit')
plot(xx1,yy1,'k-');
plot(xx2,yy2,'r-');
plot(xx3,yy3,'g-');
plot(xx4,yy4,'b-');
plot(xx5,yy5,'m-');

ylabel('sbf(t)');
xlabel('t');
legend('K1','K2','K3','K4','K5');
grid on;

%% Saving results
if SAVE
    head = {'x_H','y_H','x_L','y_L'};
    M1 = [x1;y1;xx1;yy1]';
    M2 = [x2;y2;xx2;yy2]';
    M3 = [x3;y3;xx3;yy3]';
    M4 = [x4;y4;xx4;yy4]';
    M5 = [x5;y5;xx5;yy5]';
    
    csvwrite_with_headers('supply_K1.csv',M1,head);
    csvwrite_with_headers('supply_K2.csv',M2,head);
    csvwrite_with_headers('supply_K3.csv',M3,head);
    csvwrite_with_headers('supply_K4.csv',M4,head);
    csvwrite_with_headers('supply_K5.csv',M5,head);
end
    
    