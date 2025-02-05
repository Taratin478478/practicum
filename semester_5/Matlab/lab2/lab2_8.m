%% 8
clc;

NN = 1000;
N = 10;
a = 2;
b = 1;
c1 = 2;
c2 = 1;

theta = linspace(0, 2*pi, NN);
X = a .* cos(theta) + c1;
Y = b .* sin(theta) + c2;
fig = figure();
fig.WindowState = 'maximized';
plot(X, Y, 'k');
axis([-1 5 -2 4]);
axis square;
drawSet(@(x) rhoEllipse(x, a, b, c1, c2), N);

fig = figure();
fig.WindowState = 'maximized';
plot([a, -a, -a, a, a] + c1, [b, b, -b, -b, b] + c2);
axis([-1 5 -2 4]);
axis square;
drawSet(@(x) rhoSquare(x, a, b, c1, c2), N);

fig = figure();
fig.WindowState = 'maximized';
plot([a, 0, -a, 0, a] + c1, [0, b, 0, -b, 0] + c2);
axis([-1 5 -2 4]);
axis square;
drawSet(@(x) rhoRhombus(x, a, b, c1, c2), N);


function drawSet(rho,N)
    theta = linspace(0, 2*pi*(1 - 1/N), N);
    X(1, :) = cos(theta);
    X(2, :) = sin(theta);
    P = zeros(2, N);
    Outer = zeros(2, N);
    for i = 1:N
        [~, P(:, i)] = rho(X(:, i));
        if (i > 1)
            alpha = linsolve([-X(2, i-1), X(2, i); X(1, i-1), -X(1, i)], P(:, i) - P(:, i-1));
            Outer(:, i-1) = P(:, i-1) + alpha(1) * [-X(2, i-1); X(1, i-1)];
        end
    end
    alpha = linsolve([-X(2, size(Outer, 2)), X(2, 1); X(1, size(Outer, 2)), -X(1, 1)], P(:, 1) - P(:, size(Outer, 2)));
    Outer(:, size(Outer, 2)) =  P(:, size(Outer, 2)) + alpha(1) * [-X(2, size(Outer, 2)); X(1, size(Outer, 2))];
    hold on;
    plot(P(1, :), P(2, :), '-ro','MarkerSize', 8, 'MarkerFaceColor', 'r');
    plot([P(1, size(P, 2)), P(1, 1)], [P(2, size(P, 2)), P(2, 1)], '-ro','MarkerSize', 8, 'MarkerFaceColor', 'r');
    plot(Outer(1, :), Outer(2, :), '-bo','MarkerSize', 8, 'MarkerFaceColor', 'b');
    plot([Outer(1, size(Outer, 2)), Outer(1, 1)], [Outer(2, size(Outer, 2)), Outer(2, 1)], '-bo','MarkerSize', 8, 'MarkerFaceColor', 'b');
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
    val = max([a * abs(x(1)), b * abs(x(2))]) + sum(x .* [c1; c2]);
    point(1) = a * sign(x(1)) * (abs(x(1)) > abs(x(2))) + c1;
    point(2) = b * sign(x(2)) * (abs(x(2)) > abs(x(1))) + c2;
end