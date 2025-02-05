%% 10
clc;

NN = 1000;
N = 100;
a = 2;
b = 1;
c1 = 0;
c2 = 0;


theta = linspace(0, 2*pi, NN);
X = a .* cos(theta) + c1;
Y = b .* sin(theta) + c2;
fig = figure();
fig.WindowState = 'maximized';
plot(X, Y, 'k');
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoEllipse(x, a, b, c1, c2), N);


fig = figure();
fig.WindowState = 'maximized';
plot([a, -a, -a, a, a] + c1, [b, b, -b, -b, b] + c2);
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoSquare(x, a, b, c1, c2), N);

fig = figure();
fig.WindowState = 'maximized';
plot([a, 0, -a, 0, a] + c1, [0, b, 0, -b, 0] + c2);
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoRhombus(x, a, b, c1, c2), N);


c1 = 1;
c2 = 1;
a = 1/2;
b = 1/2;

theta = linspace(0, 2*pi, NN);
X = a .* cos(theta) + c1;
Y = b .* sin(theta) + c2;
fig = figure();
fig.WindowState = 'maximized';
plot(X, Y, 'k');
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoEllipse(x, a, b, c1, c2), N);

fig = figure();
fig.WindowState = 'maximized';
plot([a, -a, -a, a, a] + c1, [b, b, -b, -b, b] + c2);
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoSquare(x, a, b, c1, c2), N);

fig = figure();
fig.WindowState = 'maximized';
plot([a, 0, -a, 0, a] + c1, [0, b, 0, -b, 0] + c2);
axis([-3 + c1 3 + c1 -3 + c2 3 + c2]);
axis square;
drawPolar(@(x) rhoRhombus(x, a, b, c1, c2), N);



function drawPolar(rho,N)
    theta = linspace(0, 2*pi*(1 - 1/N), N);
    X(1, :) = cos(theta);
    X(2, :) = sin(theta);
    P = zeros(2, N);
    for i = 1:N
        [~, P(:, i)] = rho(X(:, i));
    end
    d = 6 / (N - 1);
    Z = zeros(N, N); 
    x = -3;
    for i = 1:N
        y = -3; 
        for j = 1:N
            [Z(j, i), ~] = rho([x; y]);
            y = y + d;
        end
        x = x + d;
    end
    [X, Y] = meshgrid(linspace(-3, 3, N));
    hold on;
    contourf(X, Y, -Z, [-1 -1]);
    hold off;
end

function [val, point] = rhoEllipse(x, a, b, c1, c2)
    lambda = sqrt((x(1) * a) ^ 2 + (x(2) * b) ^ 2);
    val = lambda + sum(x .* [c1; c2]);
    point(1, 1) = x(1) * a^2 / lambda + c1;
    point(2, 1) = x(2) * b^2 / lambda + c2;
end

function [val, point] = rhoSquare(x, a, b, c1, c2) 
    val = a * abs(x(1)) + b * abs(x(2)) + sum(x .* [c1; c2]);
    point(1) = a * sign(x(1)) + c1;
    point(2) = b * sign(x(2)) + c2;
end

function [val, point] = rhoRhombus(x, a, b, c1, c2)
    val = max(a * abs(x(1)), b * abs(x(2))) + sum(x .* [c1; c2]);
    point(1) = a * sign(x(1)) * (abs(x(1)) > abs(x(2))) + c1;
    point(2) = b * sign(x(2)) * (abs(x(2)) > abs(x(1))) + c2;
end