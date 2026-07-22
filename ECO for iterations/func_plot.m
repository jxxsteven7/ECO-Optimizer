%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization.
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

function func_plot(Func_name)

[~, ~, ~, fobj] = Get_BenchFunctions(Func_name);

switch Func_name 
    case 'F1' 
        x = -100:2:100;
        y = x;
    case 'F2'
        x = -10:0.2:10;    
        y = x;
    case 'F3' 
        x = -100:2:100;    
        y = x;
    case 'F4' 
        x = -100:2:100;    
        y = x;
    case 'F5'
        x = -2:0.02:2;     
        y = -1:0.02:3;
    case 'F6' 
        x = -100:2:100;    
        y = x;
    case 'F7'
        x = -1.28:0.02:1.28;  
        y = x;
    case 'F8' 
        x = -500:10:500; y=x;
    case 'F9' 
        x = -5.12:0.1:5.12;  
        y = x;
    case 'F10' 
        x = -32:0.5:32;    
        y = x;
    case 'F11' 
        x = -600:10:600;   
        y = x;
    case 'F12' 
        x = -10:0.1:10;   
        y = x;
    case 'F13' 
        x = -5:0.08:5;    
        y = x;
    case 'F14' 
        x = -65.536:1:65.536; 
        y = x;
    case 'F15' 
        x = -5:0.1:5;     
        y = x;
    case 'F16' 
        x = -1:0.01:1;    
        y = x;
    case 'F17' 
        x = -5:0.1:10;    
        y = 0:0.1:15;
    case 'F18' 
        x = -5:0.06:5;    
        y = x;
    case 'F19' 
        x = -5:0.1:5;     
        y = x;
    case 'F20' 
        x = -5:0.1:5;     
        y = x;
    case 'F21' 
        x = -5:0.1:5;     
        y = x;
    case 'F22' 
        x = -5:0.1:5;     
        y = x;
    case 'F23' 
        x = -5:0.1:5;     
        y = x;      
end    

L = length(x);
f = [];

for i = 1:L
    for j = 1:L
        if strcmp(Func_name, 'F15') == 0 && strcmp(Func_name, 'F19') == 0 && strcmp(Func_name, 'F20') == 0 && strcmp(Func_name, 'F21') == 0 && strcmp(Func_name, 'F22') == 0 && strcmp(Func_name, 'F23') == 0
            f(i, j) = fobj([x(i), y(j)]);
        end
        if strcmp(Func_name, 'F15')==1
            f(i, j) = fobj([x(i), y(j), 0, 0]);
        end
        if strcmp(Func_name,'F19')==1
            f(i, j) = fobj([x(i), y(j), 0]);
        end
        if strcmp(Func_name, 'F20')==1
            f(i, j) = fobj([x(i), y(j), 0, 0, 0, 0]);
        end       
        if strcmp(Func_name, 'F21')==1 || strcmp(Func_name,'F22')==1 ||strcmp(Func_name,'F23')==1
            f(i, j) = fobj([x(i), y(j), 0, 0]);
        end          
    end
end

surfc(x, y, f, 'LineStyle','none');
colormap(winter);
grid on;
box on;
end
