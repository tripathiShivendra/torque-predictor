% Induction Motor Torque Model 
clc; clear;

rng(1); % For reproducibility
n_main = 1000;
n_edge = 200;

%% === MAIN DATA (original range) ===
Torque_main = 10 + (85 - 10) * rand(1, n_main);
speed_rad_per_sec = 157;
Power_main = Torque_main * speed_rad_per_sec;
pf = 0.85;

I1_main = 5 + (20 - 5).*rand(1, n_main);
I2_main = 5 + (20 - 5).*rand(1, n_main);
I3_main = 5 + (20 - 5).*rand(1, n_main);
I_avg_main = (I1_main + I2_main + I3_main)/3;
V_line_main = Power_main ./ (sqrt(3) * I_avg_main * pf);
V_line_main = min(max(V_line_main, 110), 265);  % Clamp voltages

V1_main = V_line_main; V2_main = V_line_main; V3_main = V_line_main;
Power_clipped_main = sqrt(3) .* V_line_main .* I_avg_main .* pf;
Torque_main = Power_clipped_main ./ speed_rad_per_sec;

%% === EXTRA EDGE DATA (low torque, unbalanced cases) ===
Torque_edge = 1 + (8 - 1) * rand(1, n_edge);  % Low torque
Power_edge = Torque_edge * speed_rad_per_sec;

I1_edge = 4 + (6 - 4) .* rand(1, n_edge);  % 4–6 A
I2_edge = 4 + (6 - 4) .* rand(1, n_edge);
I3_edge = 4 + (6 - 4) .* rand(1, n_edge);
I_avg_edge = (I1_edge + I2_edge + I3_edge)/3;

% Unbalanced voltages
V1_edge = 110 + (160 - 110).*rand(1, n_edge);
V2_edge = 110 + (160 - 110).*rand(1, n_edge);
V3_edge = 110 + (160 - 110).*rand(1, n_edge);

V_line_avg = (V1_edge + V2_edge + V3_edge)/3;
Power_clipped_edge = sqrt(3) .* V_line_avg .* I_avg_edge .* pf;
Torque_edge = Power_clipped_edge ./ speed_rad_per_sec;

%% === COMBINE ALL DATA ===
V1_all = [V1_main, V1_edge];
V2_all = [V2_main, V2_edge];
V3_all = [V3_main, V3_edge];
I1_all = [I1_main, I1_edge];
I2_all = [I2_main, I2_edge];
I3_all = [I3_main, I3_edge];
Torque_all = [Torque_main, Torque_edge];

Inputs = [V1_all; V2_all; V3_all; I1_all; I2_all; I3_all];

%% === TRAINING ===
fprintf('Torque Range: Min = %.2f Nm, Max = %.2f Nm\n', min(Torque_all), max(Torque_all));
net = fitnet(15, 'trainlm');
net.trainParam.showWindow = true;
net.trainParam.max_fail = 6;
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

[net, tr] = train(net, Inputs, Torque_all);
outputs = net(Inputs);

% Clamp predicted torque to avoid negatives
outputs = max(0, outputs);

%% === METRICS ===
SS_res = sum((Torque_all - outputs).^2);
SS_tot = sum((Torque_all - mean(Torque_all)).^2);
R_squared = 1 - (SS_res / SS_tot);
disp(['✅ R² value: ', num2str(R_squared)]);

%% === SAVE MODEL ===
save('InductionMotorTorqueNet.mat', 'net');
disp("✅ Model saved successfully.");
