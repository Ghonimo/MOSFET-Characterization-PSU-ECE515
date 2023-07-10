% Mohamed Ghonim - ECE 515 Fundamentals of Semiconductor Devices 
% Project 2 MOSFET Characterization
% Dr. Malgorzata Chrzanowska-Jeske

clc
clear % This clears all variables
close all % This closes all figures

% Reading the data from CSV
filename = 'Id_Vd.csv'; % update with your filename
data = xlsread(filename);

% Separating the data into vectors
V_DS = data(:,1); % Drain-Source Voltage
I_D = data(:,2); % Drain Current
V_GS = data(:,3); % Gate-Source Voltage

% Get unique V_GS values
uniqueV_GS = unique(V_GS);

% Create a figure
figure;
hold on; % This will allow multiple plots on the same figure

% Loop over unique V_GS values
for i = 1:length(uniqueV_GS)
    % Get the indices for the current V_GS
    indices = V_GS == uniqueV_GS(i);
    % Plot I_D vs V_DS for this V_GS
    plot(V_DS(indices), I_D(indices), 'LineWidth', 1.5, 'DisplayName', ['V_{GS} = ', num2str(uniqueV_GS(i)), 'V']);
end

% Adding labels and title
xlabel('V_{DS} (V)');
ylabel('I_D (A)');
title('Output Characteristics of the MOSFET');
legend('show'); % Show legend

% Holding off the figure
hold off;
