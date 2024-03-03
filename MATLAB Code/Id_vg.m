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

% Get unique V_DS values
uniqueV_DS = unique(V_DS);

% Create a figure
figure;
hold on; % This will allow multiple plots on the same figure

% Loop over unique V_DS values
for i = 1:length(uniqueV_DS)
    % Get the indices for the current V_DS
    indices = V_DS == uniqueV_DS(i);
    % Plot I_D vs V_GS for this V_DS
    plot(V_GS(indices), I_D(indices), 'LineWidth', 1.5, 'DisplayName', ['V_{DS} = ', num2str(uniqueV_DS(i)), 'V']);
end

% Adding labels and title
xlabel('V_{GS} (V)');
ylabel('I_D (A)');
title('Transfer Characteristics of the MOSFET');
legend('show','Location','northwest'); % Show legend

% Holding off the figure
hold off;
