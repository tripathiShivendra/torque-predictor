function showTorqueTrendsStatic(motorType)
    % Function to show torque trends (Torque vs Voltage and Torque vs Current)
    % based on the selected motor type ('Induction Motor' or 'DC Motor')

    disp("⚙️ Motor selected: " + motorType);

    % Load appropriate model
    switch motorType
        case 'Induction Motor'
            load('InductionMotorTorqueNet.mat', 'net');
            inputSize = 6;
            fixed_I = 10; % A constant current for trend visualization
            fixed_V = 200; % A constant voltage for trend visualization
            V_range = linspace(110, 265, 100);  % Voltage range
            I_range = linspace(5, 20, 100);     % Current range

            % Torque vs Voltage (current held constant)
            T_vs_V = arrayfun(@(v) net([v; v; v; fixed_I; fixed_I; fixed_I]), V_range);

            % Torque vs Current (voltage held constant)
            T_vs_I = arrayfun(@(i) net([fixed_V; fixed_V; fixed_V; i; i; i]), I_range);

        case 'DC Motor'
            load('DCMotorTorqueNet.mat', 'net');
            inputSize = 2;
            fixed_I = 10; % A constant current for trend visualization
            fixed_V = 200; % A constant voltage for trend visualization
            V_range = linspace(110, 265, 100);
            I_range = linspace(5, 20, 100);

            % Torque vs Voltage (current held constant)
            T_vs_V = arrayfun(@(v) net([v; fixed_I]), V_range);

            % Torque vs Current (voltage held constant)
            T_vs_I = arrayfun(@(i) net([fixed_V; i]), I_range);

        otherwise
            error("❌ Unknown motor type. Please pass 'Induction Motor' or 'DC Motor'.");
    end

    % Create a popup figure
    f = figure('Name', 'Torque Trends', 'NumberTitle', 'off', 'Position', [500, 300, 800, 400]);

    % Plot Torque vs Voltage
    subplot(1, 2, 1);
    plot(V_range, T_vs_V, 'b', 'LineWidth', 2);
    xlabel('Voltage (V)');
    ylabel('Torque (Nm)');
    title([motorType ' - Torque vs Voltage']);
    grid on;

    % Plot Torque vs Current
    subplot(1, 2, 2);
    plot(I_range, T_vs_I, 'r', 'LineWidth', 2);
    xlabel('Current (A)');
    ylabel('Torque (Nm)');
    title([motorType ' - Torque vs Current']);
    grid on;
end
