clc;
clear;

% Objective function
fun = @(x) x(1)^2 + 2*x(2)^2 - 4*x(1) - 8*x(2) + 20;

% Number of variables
nvars = 2;

% Linear inequality:
% x1 + x2 <= 10
A = [1 1];
b = 10;

% Linear equality:
% 2*x1 + x2 = 8
Aeq = [2 1];
beq = 8;

% Lower and upper bounds
lb = [0 0];
ub = [10 10];

% Nonlinear constraint:
% x1^2 + x2^2 <= 25
nonlcon = @(x) deal(x(1)^2 + x(2)^2 - 25, []);

% GA options
options = optimoptions('ga', ...
    'Display','iter', ...
    'PopulationSize',50, ...
    'MaxGenerations',100);

% Genetic Algorithm
[x,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);

% Display results
disp('Optimal values:')
disp(x)

disp('Minimum cost:')
disp(fval)