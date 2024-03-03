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
V_DS_val = 2.5; % e.g., V_DS = 2.5V

% Get the indices for the specified V_DS
indices = V_DS == V_DS_val;

% Create a figure
figure;

% Plot sqrt(I_D) vs V_GS for this V_DS
plot(V_GS(indices), sqrt(I_D(indices)), 'LineWidth', 1.5);
hold on; % To allow multiple plots on the same figure

% Define the points for fitting the line (asymptote)
V_GS_asymptote_points = [2.5, 2.6];
sqrt_ID_asymptote_points = [sqrt(I_D(V_GS == 2.5 & indices)), sqrt(I_D(V_GS == 2.6 & indices))];

% Fit a line through the specified points
P = polyfit(V_GS_asymptote_points, sqrt_ID_asymptote_points, 1);

% Generate points to draw the fitted line (asymptote)
V_GS_line = linspace(min(V_GS(indices)), max(V_GS(indices)), 100);
sqrt_ID_line = polyval(P, V_GS_line);

% Plot the asymptote
plot(V_GS_line, sqrt_ID_line, 'r', 'LineWidth', 1.5);

% Calculate the x-axis intersection
V_T_estimate = -P(2) / P(1);
disp(['The estimated threshold voltage (x-axis intersection of the asymptote) is: ', num2str(V_T_estimate), ' V']);

% Add the equation of the line to the plot
str = sprintf('y = %.3f x + %.3f', P(1), P(2));
text(mean(V_GS_line), mean(sqrt_ID_line), str, 'Color', 'red');

% Adding labels and title
xlabel('V_{GS} (V)');
ylabel('sqrt(I_D) (A^{1/2})');
title(['Square Root of Drain Current vs. Gate-Source Voltage for V_{DS} = ', num2str(V_DS_val), 'V']);

% Holding off the figure
hold off;
