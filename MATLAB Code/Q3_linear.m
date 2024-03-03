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

% Specify the V_DS value of interest
V_DS_val = 0.25; % e.g., V_DS = 0.25V

% Get the indices for the specified V_DS
indices = V_DS == V_DS_val;

% Define the points for fitting the line
line_indices = indices & V_GS >= 2.4 & V_GS <= 2.8;
V_GS_line_points = V_GS(line_indices);
ID_line_points = I_D(line_indices);

% Fit a line through the specified points
P = polyfit(V_GS_line_points, ID_line_points, 1);

% Generate points to draw the fitted line
V_GS_line = linspace(min(V_GS_line_points), max(V_GS_line_points), 100);
ID_line = polyval(P, V_GS_line);

% Calculate the x-axis intersection (threshold voltage, V_T)
V_T_estimate = -P(2) / P(1);

% Define the W/L ratio
WL_ratio = 31; % W/L = 31, from your provided info

% Calculate the μnCox product from the slope
u_n_C_ox_estimate = P(1) / (V_DS_val * WL_ratio); % dividing by V_DS and WL_ratio because the slope of ID vs VGS in the linear region is μnCox * V_DS * WL_ratio

% Print the estimated parameters
disp(['The estimated threshold voltage (x-axis intersection of the line) is: ', num2str(V_T_estimate), ' V']);
disp(['The estimated μnCox product (from the slope of the line) is: ', num2str(u_n_C_ox_estimate), ' A/V^2']);

% Create a figure
figure;

% Plot I_D vs V_GS for this V_DS
plot(V_GS(indices), I_D(indices), 'LineWidth', 1.5);
hold on; % To allow multiple plots on the same figure

% Plot the line
plot(V_GS_line, ID_line, 'r', 'LineWidth', 1.5);

% Add the equation of the line to the plot
str = sprintf('y = %.3f x + %.3f', P(1), P(2));
text(mean(V_GS_line), mean(ID_line), str, 'Color', 'red');

% Adding labels and title
xlabel('V_{GS} (V)');
ylabel('I_D (A)');
title(['Drain Current vs. Gate-Source Voltage for V_{DS} = ', num2str(V_DS_val), 'V']);

% Holding off the figure
hold off;
