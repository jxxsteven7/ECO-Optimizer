%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization.
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

% This function implements the roulette.
% Fit: fitness value array required for the roulette
% num: number of individuals selected by the roulette
% r: serial number of the num individuals calculated by the roulette

function r = Roulette(Fit, num)

r = zeros(1,num);
fit_all = 1./(Fit+eps);
P_fit = fit_all/sum(fit_all);
P = cumsum(P_fit);

for m = 1:num
    n = find(rand <= P, 1);
    r(m) = n;
end

end
