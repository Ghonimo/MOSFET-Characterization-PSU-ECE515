% Mohamed Ghonim - ECE 515 Fundamentals of Semiconductor Devices 
% Project 2 MOSFET Characterization
% Dr. Malgorzata Chrzanowska-Jeske
clc
clear % This clears all variables
close all % This closes all figures

% Reading the data from Excel
filename = 'Id_Vg.csv'; % update with your filename
data = xlsread(filename);

% Separating the data into vectors
V_GS = data(:,1); % Gate-Source Voltage
I_D = data(:,2); % Drain Current
V_DS = data(:,4); % Drain-Source Voltage

% Select data for V_DS=2V
V_DS_target = 2;
indices = find(V_DS == V_DS_target);
V_GS_target = V_GS(indices);
I_D_target = I_D(indices);

% Threshold voltage
VT = 2.082; 

% Margin around V_T
margin = 0.2;

% Select data around V_T
indices_VT = find((V_GS_target >= VT - margin) & (V_GS_target <= VT + margin));
V_GS_target_VT = V_GS_target(indices_VT);
I_D_target_VT = I_D_target(indices_VT);

% Plot log10(I_D) vs V_GS
figure
scatter(V_GS_target_VT, log10(I_D_target_VT), 'filled');
hold on;

% Fitting line
P = polyfit(V_GS_target_VT, log10(I_D_target_VT), 1);
fit_line = polyval(P, V_GS_target_VT);
plot(V_GS_target_VT, fit_line, 'LineWidth', 1.5);

% Compute Subthreshold Slope
S = P(1);

% Boltzmann constant in J/K
k = 1.38e-23; 

% Charge of an electron in C
q = 1.6e-19;

% Room temperature in K
T = 300; 

% Calculate c_r
c_r = S * q / (2.3 * k * T);

fprintf('Subthreshold slope, S = %.4f V/decade\n', S);
fprintf('The parameter c_r = %.4e\n', c_r);

% Equation of the fitted line
m = S;
c = P(2);
str = sprintf('y = %.2fx + %.2f', m, c);

% Add equation to the plot
text(VT, min(log10(I_D_target_VT)), str, 'FontSize', 12);
hold off;

xlabel('V_G_S (V)');
ylabel('log_{10}(I_D) ');
title('log_{10}(I_D) vs V_G_S for V_D_S=2V around V_T');
legend('Measured data', 'Fitted line', 'Location', 'northwest');
