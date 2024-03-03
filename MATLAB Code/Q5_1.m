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

% Choosing V_DS = 2V and near threshold voltage
V_DS_selected = 2;
VT = 2.082; % Threshold voltage (V)
VT_window = 0.1; % Range around VT to consider

% Filtering data
mask = (V_DS == V_DS_selected) & (V_GS > VT - VT_window) & (V_GS < VT + VT_window);
V_GS_subthreshold = V_GS(mask);
I_D_subthreshold = I_D(mask);

% Plotting
figure
plot(V_GS_subthreshold, I_D_subthreshold, 'b', 'LineWidth', 1.5) % Line plot
hold on
scatter(V_GS_subthreshold, I_D_subthreshold, 'MarkerEdgeColor', 'r') % Scatter plot
hold off
title('Subthreshold characteristics (I_D vs V_GS for V_DS = 2V)')
xlabel('V_GS (V)')
ylabel('I_D (A)')
legend('Data trend', 'Measured data')
grid on
