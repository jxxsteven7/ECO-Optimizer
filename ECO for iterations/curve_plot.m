%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization.
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

clear all;
clc;

% List of benchmark functions
Function_list = {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', ...
                 'F11', 'F12', 'F13', 'F14', 'F15', 'F16', 'F17', 'F18', ...
                 'F19', 'F20', 'F21', 'F22', 'F23'};  

% Define drawing style
color = [238, 102, 102] / 255;
linewidth = 3;
linestyle = '-';

% Draw function topology and mean convergence curve
for i = 1:length(Function_list)
    
    Function_name = Function_list{i};

    filename = strcat('./results/Convergence_curve_classic_', Function_name, '.csv');
    dataMatrix = readmatrix(filename);
    if size(dataMatrix, 1) > 1
        curve = mean(dataMatrix);
    else
        curve = dataMatrix;
    end
    
    % Plotting
    figure('Position', [200 100 1200 540])
    
    % Plot 1: function plot
    subplot(1,2,1);
    func_plot(Function_name); 
    xlabel('X_1', 'FontName', 'Times New Roman', 'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');
    ylabel('X_2', 'FontName', 'Times New Roman', 'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');
    zlabel(Function_name, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'bold', 'FontAngle', 'italic');
    xlabel('{\it x}_1', 'FontName', 'Times New Roman', 'FontSize', 12);
    ylabel('{\it x}_2', 'FontName', 'Times New Roman', 'FontSize', 12);
    zlabel(Function_name, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'bold', 'FontAngle', 'italic');
    
    % Plot 2: convergence curves
    subplot(1,2,2);
    if iscell(color)
        color = char(color);
    end
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12.5);
    semilogy(1:length(curve), curve, 'Color', color, 'LineWidth', linewidth, 'LineStyle', linestyle);
    switch Function_name
        case 'F1'
            ylim([10^(-300) 10^(6)]);
        case 'F2'
            ylim([10^(-150) 10^(2)]);
        case 'F3'
            ylim([10^(-280) 10^(5)]);
        case 'F4'
            ylim([10^(-200) 10^(2)]);
        case 'F5'
            ylim([10^(-5) 10^(9)]);
        case 'F6'
            ylim([10^(-5) 7*10^(4)]);
        case 'F7'
            ylim([4*10^(-5) 2*10^(2)]);
        case 'F8'
            ylim([-13000 -10^(3)]);
        case 'F9'
            ylim([10^(-6) 10^(3)]);
        case 'F10'
            ylim([10^(-16) 20]);
        case 'F11'
            ylim([10^(-7) 10^(3)]);
        case 'F12'
            ylim([10^(-13) 10^(9)]);
        case 'F13'
            ylim([10^(-12) 10^(9)]);
        case 'F14'
            ylim([0.9 12]);
        case 'F15'
            ylim([2.2*10^(-4) 5*10^(-2)]);
        case 'F16'
            ylim([-1.032 -1.0265]);
        case 'F17'
            ylim([0.3975 0.43]);
        case 'F18'
            ylim([2.98 4.4]);
        case 'F19'
            ylim([-3.865 -3.785]);
        case 'F20'
            ylim([-3.35 -1.6]);
        case 'F21'
            ylim([-10.5 -0.5]);
        case 'F22'
            ylim([-10.8 -0.5]);
        case 'F23'
            ylim([-10.8 -0.5]);
    end
    xlim([1 500]);
    legend('ECO');
    xlabel('Iterations', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold');
    ylabel('Fitness (average of 25 runs)', 'FontName', 'Times New Roman', 'FontSize', 10, 'FontWeight', 'bold'); 
    grid on;
    box on;

end














