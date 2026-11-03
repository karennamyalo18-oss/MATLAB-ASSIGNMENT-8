clc;
clear;
close all;

% Objective function
fun = @(x) 5*x(1)^2 + 4*x(2)^2 - 2*x(1)*x(2) - 50*x(1) - 40*x(2) + 300;

% Initial guess
x0 = [3 3];

% Linear inequality constraints
% x1 + x2 <= 15
% 2*x1 + x2 <= 18
% x1 + x2 >= 6
% x1 >= 0.4*x2

A = [1 1;2 1;-1 -1;-1 0.4];

b = [15;18;-6;0];

% Linear equality constraints
Aeq = [];
beq = [];

% Lower and upper bounds
lb = [0 0];
ub = [15 15];

% Nonlinear constraint
% x1^2 + x2^2 <= 100
nonlcon = @(x) deal(x(1)^2 + x(2)^2 - 100, []);

% Optimization options
options = optimoptions('fmincon', 'Algorithm','sqp', 'Display','iter');

% Run optimization
[x,fval] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);

% Display results
fprintf('\nOPTIMIZATION RESULTS\n');
fprintf('Maize flour production = %.4f tonnes/day\n',x(1));
fprintf('Cassava flour production = %.4f tonnes/day\n',x(2));
fprintf('Minimum production cost = %.4f\n',fval);

% Create grid
x1 = linspace(0,15,300);
x2 = linspace(0,15,300);

[X1,X2] = meshgrid(x1,x2);

% Objective function values
Z = 5*X1.^2 + 4*X2.^2 - 2*X1.*X2 - 50*X1 - 40*X2 + 300;

% Contour plot
figure;

contourf(X1,X2,Z,30);
colorbar;
hold on;
grid on;

% Plot optimum point
plot(x(1),x(2),'ro', 'MarkerSize',10, 'MarkerFaceColor','r');

% Labels
xlabel('Maize flour production x_1 (tonnes/day)');
ylabel('Cassava flour production x_2 (tonnes/day)');
title('Contour Plot of Agro-Processing Production Cost');

legend('Cost contours','Optimal point','Location','best');

% Display optimum coordinates
text(x(1),x(2),sprintf('  Optimum (%.2f, %.2f)',x(1),x(2)),'FontSize',10);