clear all; close all; clc;

%% Read Range Data
load('Elevation10'); load('Elevation20'); load('Elevation30')
d10 = Elevation10(1:14,2);
d20 = Elevation20(1:14,2);
d30 = Elevation30(1:14,2);
%% Compute/Read Access Time Data
load('t_Elevation10'); load('t_Elevation20'); load('t_Elevation30')
%% DATOS
EIRP = 22;      
D = 5;              % Diametro antena [m]
T_ant = 40;         % Temperatura antena [K]
B = 300e6;          % Bandwidth [Hz]
NF = 2;             % Receiver noise [dB]
L_X = 3;            % Losses due to gaseous absorption, rain attenuation... [dB]
L_Ka = 6;           % Losses due to gaseous absorption, rain attenuation... [dB]
eta = 0.6;          % Efficiency
k = -228.6;         % [dBW/(K·Hz)]
T_0 = 290;          % [K]
c = 2.998e8;        % [ms]
lambda = (c/8e9); % [m]
% Antenna gain
G = 10*log10(eta*(pi*D/lambda)^2) % [dBi]
% G/T
T = T_ant + T_0*(10^(NF/10)-1)    % [K]
G_T = G - 10*log10(T)
Lfs10 = 20*log10(4*pi*d10/lambda);
Lfs20 = 20*log10(4*pi*d20/lambda);
Lfs30 = 20*log10(4*pi*d30/lambda);

% C/N (dB)=〖EIRP〗_sat (dBW)+G/T (dB/K)-L_fs (dB)-L_a (dB)-k(dBW/K·Hz)-10〖log〗_10 (B(Hz))
t10 = 0:20:t_Elevation10(1,1)+20;t20 = 0:20:t_Elevation20(1,1)+20;t30 = 0:20:t_Elevation30(1,1)+20;

C_N_10 = EIRP * G_T - Lfs10 - L_X - k -10*log10(B);
C_N_20 = EIRP * G_T - Lfs20 - L_X - k -10*log10(B);
C_N_30 = EIRP * G_T - Lfs30 - L_X - k -10*log10(B);

figure()
hold on
box on
% xlabel('\it t \rm [s]')
set(gca,'linewidth',0.75)
set(gca,'fontsize',14)
yyaxis left
%ylabel("\it ","rotation",0,'HorizontalAlignment','right','Position',[-0.04 max(G)])
plot(t10,C_N_10)
yyaxis right
%ylabel("\it d [m]",0,'HorizontalAlignment','right','Position',[120.4 max(TT)])
plot(t10,d10)
hold off
%% TASK 2


%% FUNCTIONS