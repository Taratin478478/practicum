%% Случай устойчивой точки
clc; clear; close all;

A = 2;
alpha = 1;
beta = 1;
gamma = 3;
rho = 2;

plot_phase_portrait(A, alpha, beta, gamma, rho);

%% Случай двух точек
clc; clear; close all;

A = 1/2;
alpha = 3/2;
beta = 2/3;
gamma = 3/2;
rho = 1;

plot_phase_portrait(A, alpha, beta, gamma, rho);

%%
function plot_phase_portrait(A, alpha, beta, gamma, rho)
    theta = rho*beta/(gamma - rho*beta);
    disp(theta);
    disp(alpha*gamma/rho/(1 + alpha));
    M = [alpha; 0; gamma/rho];
    N = [theta; (A/theta + 1)*(alpha - theta); gamma/rho];
    disp(M);
    disp(N);
    f1 = @(u, v, q) alpha - u - u.*v./(A+u);
    f2 = @(u, v, q) u.*v.*q./(1+u) - beta*v;
    f3 = @(u, v, q) gamma - rho*q;
    f = @(t, y) [f1(y(1), y(2), y(3)); f2(y(1), y(2), y(3)); f3(y(1), y(2), y(3))];
    
    tspan = [0, 10];
    x0 = 0;
    x1 = 2;
    n = 8;
    
    x = linspace(x0, x1, n);
    [X, Y, Z] = meshgrid(x);
    fig = figure('Name', 'Трехмерный фазовый портрет');
    fig.WindowState = 'maximized';
    V(:, :, :, 1) = f1(X, Y, Z);
    V(:, :, :, 2) = f2(X, Y, Z);
    V(:, :, :, 3) = f3(X, Y, Z);
    quiver3(X, Y, Z, f1(X, Y, Z), f2(X, Y, Z), f3(X, Y, Z), 'color', [0.5, 0.5, 0.5]);
    [X, Y] = meshgrid(x);
    hold on;
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [X(i, j); Y(i, j); x0];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [X(i, j); Y(i, j); x1];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [X(i, j); x0; Y(i, j)];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [X(i, j); x1; Y(i, j)];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [x0; X(i, j); Y(i, j)];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            y0 = [x1; X(i, j); Y(i, j);];
            [~, y] = ode45(f, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3), 'b');
        end
    end
    p1 = scatter3(M(1), M(2), M(3), 200, 'r', 'filled');
    if (N(1) >= 0) && (N(2) >=0)
        p2 = scatter3(N(1), N(2), N(3), 200, 'g', 'filled');
        legend([p1, p2], {'M', 'N'});
    else
        legend(p1, 'M');
    end
    hold off;
    axis([x0, x1, x0, x1, x0, x1]);
    xlabel('u');
    ylabel('v');
    zlabel('q');
    grid on;
    axis square;
    
    
    tspan = [0, 10];
    x0 = 0;
    x1 = 2;
    n = 12;
    x = linspace(x0, x1, n);
    [X, Y] = meshgrid(x);
    
    fig = figure('Name', 'Фазовый портрет в плоскости uv');
    fig.WindowState = 'maximized';
    Z = zeros(size(X));
    quiver(X, Y, f1(X, Y, Z), f2(X, Y, Z), 'color', [0.5, 0.5, 0.5]);
    axis([x0, x1, x0, x1]);
    hold on;
    for i = 1:n
            y0 = [x(i); x0; 0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 2), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x(i); x1; 0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 2), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x0; x(i); 0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 2), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x1; x(i); 0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 2), 'b', 'linewidth', 2);
    end
    p1 = scatter(M(1), M(2), 200, 'r', 'filled');
    if (N(1) >= 0) && (N(2) >=0)
        p2 = scatter(N(1), N(2), 200, 'g', 'filled');
        legend([p1, p2], {'M', 'N'});
    else
        legend(p1, 'M');
    end
    hold off;
    xlabel('u');
    ylabel('v');
    axis square;
    grid on;

    fig = figure('Name', 'Фазовый портрет в плоскости uq');
    fig.WindowState = 'maximized';
    Z = zeros(size(X));
    quiver(X, Y, f1(X, Z, Y), f3(X, Z, Y), 'color', [0.5, 0.5, 0.5]);
    axis([x0, x1, x0, x1]);
    hold on;
    for i = 1:n
            y0 = [x(i); 0; x0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x(i); 0; x1];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x0; 0; x(i)];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [x1; 0; x(i)];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 1), y(:, 3), 'b', 'linewidth', 2);
    end
    p1 = scatter(M(1), M(3), 200, 'r', 'filled');
    if (N(1) >= 0) && (N(2) >=0)
        p2 = scatter(N(1), N(3), 200, 'g', 'filled');
        legend([p1, p2], {'M', 'N'});
    else
        legend(p1, 'M');
    end
    hold off;
    xlabel('u');
    ylabel('q');
    axis square;
    grid on;

    fig = figure('Name', 'Фазовый портрет в плоскости vq');
    fig.WindowState = 'maximized';
    Z = zeros(size(X));
    quiver(X, Y, f2(Z, X, Y), f3(Z, X, Y), 'color', [0.5, 0.5, 0.5]);
    axis([x0, x1, x0, x1]);
    hold on;
    for i = 1:n
            y0 = [0; x(i); x0];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 2), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [0; x(i); x1];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 2), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [0; x0; x(i)];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 2), y(:, 3), 'b', 'linewidth', 2);
    end
    for i = 1:n
            y0 = [0; x1; x(i)];
            [~, y] = ode45(f, tspan, y0);
            plot(y(:, 2), y(:, 3), 'b', 'linewidth', 2);
    end
    p1 = scatter(M(2), M(3), 200, 'r', 'filled');
    if (N(1) >= 0) && (N(2) >=0)
        p2 = scatter(N(2), N(3), 200, 'g', 'filled');
        legend([p1, p2], {'M', 'N'});
    else
        legend(p1, 'M');
    end
    hold off;
    xlabel('v');
    ylabel('q');
    axis square;
    grid on;
end

