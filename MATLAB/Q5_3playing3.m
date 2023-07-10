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

% Select data in the range 0.6V <= V_GS <= 1.5V for fitting
indices_fit = find((V_GS_target >= 0.6) & (V_GS_target <= 1 ...
    ));
V_GS_target_fit = V_GS_target(indices_fit);
I_D_target_fit = I_D_target(indices_fit);

% Plot log10(I_D) vs V_GS for all data as scatter
figure
scatter(V_GS_target, log10(I_D_target), 'filled');
hold on;

% Plot the trend line
plot(V_GS_target, log10(I_D_target), '-', 'LineWidth', 1.5,'Color', 'black');

% Fitting line on the subset of data
P = polyfit(V_GS_target_fit, log10(I_D_target_fit), 1);
fit_line = polyval(P, V_GS_target_fit);

% Plot the fitted line over the original scatter plot
plot(V_GS_target_fit, fit_line, 'LineWidth', 1.5, 'Color', 'r');

% Compute Subthreshold Slope
S = 1 / P(1); % Corrected computation of S

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
m = P(1); % m here is the slope of the line, not S.
c = P(2);
str = sprintf('y = %.2fx + %.2f', m, c);

% Add equation to the plot
text(min(V_GS_target_fit), min(log10(I_D_target_fit)), str, 'FontSize', 12);
hold off;

xlabel('V_G_S (V)');
ylabel('log_{10}(I_D) ');
title('log_{10}(I_D) vs V_G_S for V_D_S=2V and Fit for 0.6V <= V_G_S <= 1V');
legend('Measured data', 'Data trend', 'Fitted line', 'Location', 'northwest');
