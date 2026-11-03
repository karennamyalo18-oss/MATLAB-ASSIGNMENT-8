clc;
clear;
close all;

% PI Controller Optimization

% Objective function
J = @(x) 100 - 2*(x(1)-4).^2 - 3*(x(2)-2).^2 - 0.5*x(1).*x(2);

% fminsearch minimizes, so use negative performance for maximization
fun = @(x) -J(x);

% Initial values [Kp Ki]
x0 = [3 2];

% fminsearch options
options = optimset('Display','iter');

% Optimization
[xopt,fval] = fminsearch(fun,x0,options);

% Optimal controller gains
Kp = xopt(1);
Ki = xopt(2);

% Maximum performance
Jmax = J(xopt);

fprintf('Optimal Kp = %.4f\n',Kp);
fprintf('Optimal Ki = %.4f\n',Ki);
fprintf('Maximum Performance = %.4f\n',Jmax);

% Create data for plots

Kp_values = linspace(0.1,8,100);
Ki_values = linspace(0.1,6,100);

[KP,KI] = meshgrid(Kp_values,Ki_values);

Performance = 100 - 2*(KP-4).^2- 3*(KI-2).^2- 0.5*KP.*KI;

% Plot 1: 3-D Surface Plot

figure;

surf(KP,KI,Performance);

hold on;

plot3(Kp,Ki,Jmax,'ro','MarkerSize',10,'MarkerFaceColor','r');

xlabel('Kp');
ylabel('Ki');
zlabel('Controller Performance');

title('PI Controller Optimization - 3D Surface');

grid on;
shading interp;

% Plot 2: Contour Plot

figure;

contourf(KP,KI,Performance,30);

hold on;

plot(Kp,Ki,'ro','MarkerSize',10,'MarkerFaceColor','r');

xlabel('Kp');
ylabel('Ki');

title('PI Controller Optimization - Contour Plot');

colorbar;
grid on;