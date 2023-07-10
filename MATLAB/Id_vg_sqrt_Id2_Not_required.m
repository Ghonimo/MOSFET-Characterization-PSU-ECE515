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

% Create a figure
figure;
hold on; % This will allow multiple plots on the same figure

% Specify the V_DS values of interest
V_DS_values = [2.5, 0.25]; % e.g., V_DS = 2.5V and V_DS = 0.25V

% Loop over the selected V_DS values
for V_DS_val = V_DS_values
    % Get the indices for the current V_DS
    indices = V_DS == V_DS_val;
    % Plot sqrt(I_D) vs V_GS for this V_DS
    plot(V_GS(indices), sqrt(I_D(indices)), 'LineWidth', 1.5, 'DisplayName', ['V_{DS} = ', num2str(V_DS_val), 'V']);
end

% Adding labels and title
xlabel('V_{GS} (V)');
ylabel('sqrt(I_D) (A^{1/2})');
title('Square Root of Drain Current vs. Gate-Source Voltage for Selected V_{DS} Values');
legend('show'); % Show legend

% Holding off the figure
hold off;
