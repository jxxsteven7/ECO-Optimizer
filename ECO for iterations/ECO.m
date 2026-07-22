%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

function [Best_pos, Best_fit, Convergence_curve] = ECO(Pop_size, Max_it, Low, Up, dim, fobj)

% Proportion of producers, herbivores, carnivores, and omnivores in the population
P_producer = 0.2;
P_herbivore = 0.3;
P_carnivore = 0.3;
% P_omnivore = 0.2;

% Number of producers, herbivores, carnivores, omnivores, and decomposers
Pro_num = round(Pop_size * P_producer);
Her_num = round(Pop_size * P_herbivore);
Car_num = round(Pop_size * P_carnivore);
Omn_num = Pop_size - Pro_num - Her_num - Car_num;
Dec_num = Pop_size;

% Decompose probabilities
P_opt = 0.6;
P_loc = 0.6;

lb = Low.*ones(1, dim);
ub = Up.*ones(1, dim);

Convergence_curve=zeros(1,Max_it);

% Initialize the solutions and values of all individuals in the population
Pop_pos = zeros(Pop_size, dim);
Pop_fit = zeros(1, Pop_size);
for i = 1:Pop_size
    Pop_pos(i,:) = lb + (ub-lb).*rand(1,dim);
    Pop_fit(i) = fobj(Pop_pos(i,:));
end
[Best_fit, Best_num] = min(Pop_fit);
Best_pos = Pop_pos(Best_num,:);

% Initialize the solutions and values of producers, herbivores, carnivores, and omnivores
Producer_pos  = Pop_pos(1:Pro_num,:);
Producer_fit  = Pop_fit(1:Pro_num);
Herbivore_pos = Pop_pos(Pro_num+1:Pro_num+Her_num,:);
Herbivore_fit = Pop_fit(Pro_num+1:Pro_num+Her_num);
Carnivore_pos = Pop_pos(Pro_num+Her_num+1:Pro_num+Her_num+Car_num,:);
Carnivore_fit = Pop_fit(Pro_num+Her_num+1:Pro_num+Her_num+Car_num);
Omnivore_pos  = Pop_pos(Pro_num+Her_num+Car_num+1:Pro_num+Her_num+Car_num+Omn_num,:);
Omnivore_fit  = Pop_fit(Pro_num+Her_num+Car_num+1:Pro_num+Her_num+Car_num+Omn_num);

% Define the predation coefficient G
G = zeros(1,dim);

% Main loop of ECO
for It = 1:Max_it

    % Update the predation coefficient G
    for k=1:dim
        G(k)=1+2*rand*exp(-9*(It/Max_it)^3)*(-1)^randi([1 2]);
    end
    
    %% (1) Producer strategy
    if It~=1
        pos_hybrid = [Decomposer_pos; Producer_pos];
        fit_hybrid = [Decomposer_fit, Producer_fit];
        [fit_hybrid,index] = sort(fit_hybrid, 'ascend');
        pos_hybrid = pos_hybrid(index,:);
        Producer_pos = pos_hybrid(1:Pro_num,:);
        Producer_fit = fit_hybrid(1:Pro_num);
        if Producer_fit(1) < Best_fit
            Best_pos = Producer_pos(1,:);
            Best_fit = Producer_fit(1);
        end
    end  
    
    %% (2) Herbivore strategy
    r1 = Roulette(Producer_fit,3);
    for i = 1:Her_num
        Her_new(1,:) = Herbivore_pos(i,:)+G.*(rand*(Producer_pos(r1(1),:)-Herbivore_pos(i,:))...
                     + rand*(Producer_pos(r1(2),:)-Herbivore_pos(i,:))+rand*(Producer_pos(r1(3),:)-Herbivore_pos(i,:)));
          
        % Judge and transform the individual solution beyond the feasible region into the search space boundaries
        Her_new = Boundmapping(Her_new, lb, ub, dim);

        % Compare and update the best solution and value of the current individual, 
        % as well as the best solution and value of the objective function obtained so far
        [Herbivore_pos(i,:), Herbivore_fit(i), Best_pos,Best_fit] = Pos_update(Herbivore_pos(i,:), Herbivore_fit(i), Her_new,Best_pos, Best_fit, fobj);
    end
        
    %% (3) Carnivore strategy
    r2 = Roulette(Herbivore_fit,3);
    for i=1:Car_num  
        Car_new(1,:) = Carnivore_pos(i,:)+G.*(rand*(Herbivore_pos(r2(1),:)-Carnivore_pos(i,:))...
                     + rand*(Herbivore_pos(r2(2),:)-Carnivore_pos(i,:))+rand*(Herbivore_pos(r2(3),:)-Carnivore_pos(i,:)));
        Car_new = Boundmapping(Car_new,lb,ub,dim);
        [Carnivore_pos(i,:), Carnivore_fit(i), Best_pos,Best_fit] = Pos_update(Carnivore_pos(i,:), Carnivore_fit(i), Car_new,Best_pos, Best_fit, fobj);
    end
    
    %% (4) Omnivore strategy
    r3 = Roulette(Producer_fit,1);
    r4 = Roulette(Herbivore_fit,1);
    r5 = Roulette(Carnivore_fit,2);
    for i = 1:Omn_num    
        Omn_new(1,:) = Omnivore_pos(i,:) + G.*(rand*(Producer_pos(r3,:) - Omnivore_pos(i,:))...
                     + rand*(Herbivore_pos(r4,:) - Omnivore_pos(i,:)) + rand*(Carnivore_pos(r5(1),:) - Omnivore_pos(i,:))...
                     + rand*(Carnivore_pos(r5(2),:) - Omnivore_pos(i,:)));
          
        Omn_new = Boundmapping(Omn_new, lb, ub, dim);
        [Omnivore_pos(i,:), Omnivore_fit(i), Best_pos, Best_fit] = Pos_update(Omnivore_pos(i,:), Omnivore_fit(i), Omn_new, Best_pos, Best_fit, fobj);
    end
    
    %% (5) Decomposer strategy
    Decomposer_pos = [Producer_pos; Herbivore_pos; Carnivore_pos; Omnivore_pos];
    Decomposer_fit = [Producer_fit, Herbivore_fit, Carnivore_fit, Omnivore_fit];
    [~, min_num] = min(Decomposer_fit);
    
    for i = 1:Dec_num
        % Optimal decomposition
        if rand < P_opt
            Bestpos_neihood = Decomposer_pos(min_num,:).*rand(1,dim);
            Dec_new = Bestpos_neihood + (0.4*rand - 0.2).*(Bestpos_neihood - Decomposer_pos(i,:));
        % Random decomposition
        else
            if rand < P_loc       
                % Local random decomposition
                dis = norm(Decomposer_pos(min_num,:) - Decomposer_pos(i,:));
                rand_vec = 2*rand(1, dim) - 1;
                rand_norm = rand_vec/(eps + norm(rand_vec));
                Dec_new = Decomposer_pos(i,:) + rand*dis*rand_norm;
            else
                % Global random decomposition
                H = (1-It/(1.5*Max_it)).^(5*It/Max_it)*(cos(pi*rand));
                rand_walk = 2/3*H*rand*min(Low-Up);
                weight = rand;
                Dec_new = weight*Decomposer_pos(i,:) + (1-weight)*rand_walk;
            end
        end
        Dec_new = Boundmapping(Dec_new, lb, ub, dim);
        [Decomposer_pos(i,:), Decomposer_fit(i), Best_pos, Best_fit] = Pos_update(Decomposer_pos(i,:), Decomposer_fit(i), Dec_new, Best_pos, Best_fit, fobj);
    end
    
    % Save the best value for the current iteration
    Convergence_curve(It) = Best_fit;   

end

end
