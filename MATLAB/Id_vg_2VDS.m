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

% Specify the two V_DS values of interest
V_DS1 = min(unique(0.25)); % e.g., minimum V_DS
V_DS2 = max(unique(2.5)); % e.g., maximum V_DS

% Create a figure
figure;
hold on; % This will allow multiple plots on the same figure

% Loop over the two selected V_DS values
for V_DS_val = [V_DS1, V_DS2]
    % Get the indices for the current V_DS
    indices = V_DS == V_DS_val;
    % Plot I_D vs V_GS for this V_DS
    plot(V_GS(indices), I_D(indices), 'LineWidth', 1.5, 'DisplayName', ['V_{DS} = ', num2str(V_DS_val), 'V']);
end

% Adding labels and title
xlabel('V_{GS} (V)');
ylabel('I_D (A)');
title('Transfer Characteristics of the MOSFET for Selected V_{DS} Values');
legend('show'); % Show legend

% Holding off the figure
hold off;
