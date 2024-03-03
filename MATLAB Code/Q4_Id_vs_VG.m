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

% Extracted parameters from the saturation region
mu_nCox = 0.0075427;  % (A/V^2)
VT = 2.082; % Threshold voltage (V)
W_L = 31; % Aspect ratio W/L 

% V_GS values for the model
V_GS_values = 0:0.01:3.5;

% Selected V_DS values
V_DS_values = [1, 1.75, 2,2.25, 2.5];

figure;

for i = 1:length(V_DS_values)
    % Select the data for the current V_DS value
    indices = abs(V_DS - V_DS_values(i)) < 1e-3;
    V_GS_data = V_GS(indices);
    I_D_data = sqrt(abs(I_D(indices)));
    
    % Plot the experimental data
    scatter(V_GS_data, I_D_data, 'DisplayName', ['V_DS = ', num2str(V_DS_values(i)), 'V (Measured)']);
    hold on;
    
    % MOSFET I-V model for both regions
    V_DSAT = max(0, V_GS_values - VT); % calculate V_DSAT
    I_D_model = mu_nCox * W_L * ((V_GS_values - VT).*V_DS_values(i) - 0.5.*V_DS_values(i).^2);
    I_D_model_saturation = mu_nCox * W_L * ((V_GS_values - VT).*V_DSAT - 0.5.*V_DSAT.^2);
    
    % Limiting I_D_model to saturation region when V_DS >= V_DSAT
    I_D_model(V_DS_values(i) >= V_DSAT) = I_D_model_saturation(V_DS_values(i) >= V_DSAT);
    
    % Plot the modeled data
    plot(V_GS_values, sqrt(abs(I_D_model)), 'DisplayName', ['V_DS = ', num2str(V_DS_values(i)), 'V (Model)'], 'LineWidth', 1.5);
end

title('sqrt(I_D) vs V_GS for different V_DS values (Measured and Modeled)');
xlabel('V_GS (V)');
ylabel('sqrt(I_D) (sqrt(A))');
legend('Location', 'northwest');
grid on;
