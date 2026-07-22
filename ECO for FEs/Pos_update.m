%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization.
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

function [Pos,Fit,Best_pos,Best_fit] = Pos_update(pos_old, pos_fitold, pos_new, Best_pos, Best_fit, fobj)

% Update the best solution and value of the current individual
pos_fitnew = fobj(pos_new);

if pos_fitnew < pos_fitold
    Pos = pos_new;
    Fit = pos_fitnew;
    % Update the best solution and value of the objective function
    if pos_fitnew < Best_fit
        Best_pos = pos_new;
        Best_fit = pos_fitnew;
    end
else
    Pos = pos_old;
    Fit = pos_fitold;
end

end