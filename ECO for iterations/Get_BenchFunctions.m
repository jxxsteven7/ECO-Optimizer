%----------------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization
%
%  Authors: Boyu Ma* (boyu.ma@ntu.edu.sg), Jiaxiao Shi* (jiaxiao.shi@ntu.edu.sg), Yiming Ji, Zhengpu Wang
%
%  Project Page: https://jxxsteven7.github.io/ECO-Optimizer/
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%----------------------------------------------------------------------------------------------------------------------

function [lb, ub, dim, fobj] = Get_BenchFunctions(Function_name)

switch Function_name
    
    case 'F1'
        fobj = @F1;
        lb = -100;
        ub = 100;
        dim = 30;
    
    case 'F2'
        fobj = @F2;
        lb = -10;
        ub = 10;
        dim = 30;
    
    case 'F3'
        fobj = @F3;
        lb = -100;
        ub = 100;
        dim = 30;
    
    case 'F4'
        fobj = @F4;
        lb =-100;
        ub = 100;
        dim = 30;
    
    case 'F5'
        fobj = @F5;
        lb = -30;
        ub = 30;
        dim = 30;
    
    case 'F6'
        fobj = @F6;
        lb = -100;
        ub = 100;
        dim = 30;
    
    case 'F7'
        fobj = @F7;
        lb = -1.28;
        ub = 1.28;
        dim = 30;
    
    case 'F8'
        fobj = @F8;
        lb = -500;
        ub = 500;
        dim = 30;
        
    case 'F9'
        fobj = @F9;
        lb = -5.12;
        ub = 5.12;
        dim = 30;
    
    case 'F10'
        fobj = @F10;
        lb = -32;
        ub= 32;
        dim = 30;
    
    case 'F11'
        fobj = @F11;
        lb = -600;
        ub = 600;
        dim = 30;
    
    case 'F12'
        fobj = @F12;
        lb = -50;
        ub = 50;
        dim = 30;
    
    case 'F13'
        fobj = @F13;
        lb = -50;
        ub = 50;
        dim = 30;
    
    case 'F14'
        fobj = @F14;
        lb = -65.536;
        ub = 65.536;
        dim = 2;
    
    case 'F15'
        fobj = @F15;
        lb = -5;
        ub = 5;
        dim = 4;
    
    case 'F16'
        fobj = @F16;
        lb = -5;
        ub = 5;
        dim = 2;
    
    case 'F17'
        fobj = @F17;
        lb = [-5,0];
        ub = [10,15];
        dim = 2;
    
    case 'F18'
        fobj = @F18;
        lb = -2;
        ub = 2;
        dim = 2;
   
    case 'F19'
        fobj = @F19;
        lb = 0;
        ub = 1;
        dim = 3;
       
    case 'F20'
        fobj = @F20;
        lb = 0;
        ub = 1;
        dim = 6;     
    
    case 'F21'
        fobj = @F21;
        lb = 0;
        ub = 10;
        dim = 4;    
    
    case 'F22'
        fobj = @F22;
        lb = 0;
        ub = 10;
        dim = 4;    
       
    case 'F23'
        fobj = @F23;
        lb = 0;
        ub = 10;
        dim = 4;            
end

end

% F1: Sphere Function
function o = F1(x)
o = sum(x.^2);
end

% F2: Schwefel's Problem 2.22
function o = F2(x)
o = sum(abs(x)) + prod(abs(x));
end

% F3: Schwefel's Problem 1.2
function o = F3(x)
dim = size(x,2);
o = 0;
for i=1:dim
    o = o + sum(x(1:i))^2;
end
end

% F4: Schwefel's Problem 2.21
function o = F4(x)
o = max(abs(x));
end

% F5: Generalized Rosenbrock's Function
function o = F5(x)
dim = size(x,2);
o = sum(100*(x(2:dim) - (x(1:dim-1).^2)).^2 + (x(1:dim-1)-1).^2);
end

% F6: Step Function
function o = F6(x)
o = sum(floor(abs(x+.5)).^2);
end

% F7: Quartic Function with Noise
function o = F7(x)
dim = size(x,2);
o = sum([1:dim].*(x.^4))+rand;
end

% F8: Generalized Schwefel's Problem 2.26
function o = F8(x)
o = sum(-x.*sin(sqrt(abs(x))));
end

% F9: Generalized Rastrigin's Function
function o = F9(x)
dim = size(x,2);
o = sum(x.^2-10*cos(2*pi.*x)) + 10*dim;
end

% F10: Ackley's Function
function o = F10(x)
dim = size(x,2);
o = -20*exp(-.2*sqrt(sum(x.^2)/dim)) - exp(sum(cos(2*pi.*x))/dim) + 20 + exp(1);
end

% F11: Generalized Griewank's Function
function o = F11(x)
dim = size(x,2);
o = sum(x.^2)/4000 - prod(cos(x./sqrt([1:dim]))) + 1;
end

% F12: Generalized Penalized Function (case-1)
function o = F12(x)
dim = size(x,2);
o = (pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2) + sum((((x(1:dim-1)+1)./4).^2).*...
    (1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2)) + ((x(dim)+1)/4)^2) + sum(Ufun(x,10,100,4));
end

% F13: Generalized Penalized Function (case-2)
function o = F13(x)
dim = size(x,2);
o = .1*((sin(3*pi*x(1)))^2 + sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
    ((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2)) + sum(Ufun(x,5,100,4));
end

% F14: Shekel's Foxholes Function
function o = F14(x)
aS = [-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32; ...
      -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];

for j = 1:25
    bS(j) = sum((x'-aS(:,j)).^6);
end
o = (1/500 + sum(1./([1:25]+bS))).^(-1);
end

% F15: Kowalik's Function
function o = F15(x)
aK = [.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK = [.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o = sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

% F16: Six-Hump Camel-Back Function
function o = F16(x)
o = 4*(x(1)^2) - 2.1*(x(1)^4) + (x(1)^6)/3+x(1)*x(2) - 4*(x(2)^2) + 4*(x(2)^4);
end

% F17: Branin Function
function o = F17(x)
o = (x(2)-(x(1)^2)*5.1/(4*(pi^2)) + 5/pi*x(1)-6)^2 + 10*(1-1/(8*pi))*cos(x(1)) + 10;
end

% F18: Goldstein-Price Function
function o = F18(x)
o = (1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
    (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

% F19: Hartman's Family
function o = F19(x)
aH = [3 10 30; .1 10 35; 3 10 30; .1 10 35];
cH = [1 1.2 3 3.2];
pH = [.3689 .117 .2673; .4699 .4387 .747; .1091 .8732 .5547; .03815 .5743 .8828];
o = 0;
for i = 1:4
    o = o - cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F20: Hartman's Family
function o = F20(x)
aH = [10 3 17 3.5 1.7 8; .05 10 17 .1 8 14; 3 3.5 1.7 10 17 8; 17 8 .05 10 .1 14];
cH = [1 1.2 3 3.2];
pH = [.1312 .1696 .5569 .0124 .8283 .5886; .2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650; .4047 .8828 .8732 .5743 .1091 .0381];
o = 0;
for i = 1:4
    o = o - cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F21: Shekel's Family
function o = F21(x)
aSH = [4 4 4 4;1 1 1 1; 8 8 8 8;6 6 6 6; 3 7 3 7;2 9 2 9; 5 5 3 3; 8 1 8 1;6 2 6 2; 7 3.6 7 3.6];
cSH = [.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o = 0;
for i = 1:5
    o = o - ((x-aSH(i,:))*(x-aSH(i,:))' + cSH(i))^(-1);
end
end

% F22: Shekel's Family
function o = F22(x)
aSH = [4 4 4 4; 1 1 1 1; 8 8 8 8; 6 6 6 6; 3 7 3 7; 2 9 2 9; 5 5 3 3; 8 1 8 1; 6 2 6 2; 7 3.6 7 3.6];
cSH = [.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o = 0;
for i = 1:7
    o = o - ((x-aSH(i,:))*(x-aSH(i,:))' + cSH(i))^(-1);
end
end

% F23: Shekel's Family
function o = F23(x)
aSH = [4 4 4 4; 1 1 1 1; 8 8 8 8; 6 6 6 6; 3 7 3 7; 2 9 2 9; 5 5 3 3; 8 1 8 1; 6 2 6 2; 7 3.6 7 3.6];
cSH = [.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
o = 0;
for i = 1:10
    o = o - ((x-aSH(i,:))*(x-aSH(i,:))' + cSH(i))^(-1);
end
end

function o = Ufun(x, a, k, m)
o = k.*((x-a).^m).*(x>a) + k.*((-x-a).^m).*(x<(-a));
end