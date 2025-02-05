%% 9
clc;
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
%options = [];
rho = supportLebesgue(@(x) x(1)^2 + x(2)^2 - 1, options);

NN = 1000;
N = 10;
a = 1;
b = 1;
c1 = 0;
c2 = 0;

theta = linspace(0, 2*pi, NN);
X = a .* cos(theta) + c1;
Y = b .* sin(theta) + c2;
fig = figure();
fig.WindowState = 'maximized';
plot(X, Y, 'k');
axis([-3 3 -3 3]);
axis square;
drawSet(rho, N);


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

function rho = supportLebesgue(f, opts)
    x0 = fmincon(f, [0, 0], [], [], [], []);
    function [val, point] = rho1(l, x0, f, opts)
        [point, val] = fmincon(@(x) x(1)*l(1) + x(2)*l(2), x0, [], [], [], [], [-3, -3], [3, 3], @(x) constraints(x, f), opts);
        point = point';
        disp(val);
        disp(point);
        function [c,ceq] = constraints(x, f)
            c = f(x);
            ceq = [];
        end
    end
    rho = @(x) rho1(x, x0, f, opts);
end