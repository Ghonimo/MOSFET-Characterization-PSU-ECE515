% Mohamed Ghonim - ECE 515 Fundamentals of Semiconductor Devices 
% Project 2 MOSFET Characterization
% Dr. Malgorzata Chrzanowska-Jeske
clc
clear % This clears all variables
close all % This closes all figures

% Reading the data from Excel
filename = 'Id_Vd.csv'; % update with your filename
data = xlsread(filename);

% Separating the data into vectors
V_DS = data(:,1); % Drain-Source Voltage
I_D = data(:,2); % Drain Current
V_GS = data(:,3); % Gate-Source Voltage

% Extracted parameters from the saturation region
mu_nCox = 0.0075427;  % (A/V^2)
VT = 2.082; % Threshold voltage (V)
W_L = 31; % Aspect ratio W/L 

% V_DS values for the model
V_DS_values = 0:0.01:3.5;

% Unique V_GS values
V_GS_values = unique(V_GS);

figure;

for i = 1:length(V_GS_values)
    % Select the data for the current V_GS value
    indices = abs(V_GS - V_GS_values(i)) < 1e-3;
    V_DS_data = V_DS(indices);
    I_D_data = I_D(indices);
    
    % Plot the experimental data
    scatter(V_DS_data, I_D_data, 'DisplayName', ['V_GS = ', num2str(V_GS_values(i)), 'V (Measured)']);
    hold on;
    
    % MOSFET I-V model for both regions
    V_DSAT = max(0, V_GS_values(i) - VT); % calculate V_DSAT
    I_D_model = mu_nCox * W_L * ((V_GS_values(i) - VT).*V_DS_values - 0.5.*V_DS_values.^2);
    I_D_model_saturation = mu_nCox * W_L * ((V_GS_values(i) - VT).*V_DSAT - 0.5.*V_DSAT.^2);
    
    % Limiting I_D_model to saturation region when V_DS >= V_DSAT
    I_D_model(V_DS_values >= V_DSAT) = I_D_model_saturation;
    
    % Plot the modeled data
    plot(V_DS_values, I_D_model, 'DisplayName', ['V_GS = ', num2str(V_GS_values(i)), 'V (Model)'], 'LineWidth', 1.5);
end

title('I_D vs V_DS for different V_GS values (Measured and Modeled)');
xlabel('V_DS (V)');
ylabel('I_D (A)');
legend('Location', 'northwest');
grid on;
