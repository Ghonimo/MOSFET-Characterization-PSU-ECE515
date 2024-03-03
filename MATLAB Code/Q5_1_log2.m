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

% Choosing V_DS = 2V
V_DS_selected = 2;

% Filtering data
mask = (V_DS == V_DS_selected);
V_GS_all = V_GS(mask);
I_D_all = I_D(mask);

% Plotting
figure
semilogy(V_GS_all, I_D_all, 'b', 'LineWidth', 1.5) % Line plot
hold on
scatter(V_GS_all, log10(I_D_all), 'MarkerEdgeColor', 'r') % Scatter plot
hold off
title('Logarithmic I_D vs V_GS for V_DS = 2V')
xlabel('V_GS (V)')
ylabel('log_{10}(I_D) (A)')
legend('Data trend')
grid on
