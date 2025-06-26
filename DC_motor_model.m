% DC Motor Torque Prediction Model
clc; clear;

rng(2);  % Different seed

n_samples = 1000;

% Voltage [V]: Range for DC motor
V = 90 + (230 - 90) * rand(1, n_samples);

% Current [A]
I = 2 + (15 - 2) * rand(1, n_samples);

% Inputs
Inputs = [V; I];

% Torque formula (kept max ~50 Nm)
Torque = 0.02 * V .* I;

% Display torque range
fprintf('Torque Range: Min = %.2f, Max = %.2f\n', min(Torque), max(Torque));

% Targets
Targets = Torque;

% Create and train the ANN
net = fitnet(10, 'trainlm');
net.trainParam.showWindow = true;
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train
[net, tr] = train(net, Inputs, Targets);

% Evaluate R²
Y_pred = net(Inputs);
R2 = 1 - sum((Targets - Y_pred).^2) / sum((Targets - mean(Targets)).^2);
fprintf('R² = %.4f\n', R2);

% Save the model
save('DCMotorTorqueNet.mat', 'net');
disp("✅ DC Motor model saved!");
