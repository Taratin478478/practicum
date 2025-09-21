%% compute
% Начальное решение задачи

clc; clear; close all;

params = init_params();
points = get_points(params); % Точки пересечения границ круга и ромба

[X, T, U, i0, params.phi0, params.T] = compute(params, -1, {}, {}, {}, 0);
if i0 ~= -1
    fprintf('Задача быстродействия решена с приближенным временем быстродействия T = %f\n', params.T);
end

%% improve
% Улучшение точности решения

mode = input('Режим улучшения точности решения. Введите 1 для глобального увеличения перебираемых параметров в 2 раза\n или 2 для локального перебора параметров вблизи текущего оптимального решения\n');
if mode == 1
    [X, T, U, i0, params.phi0, params.T] = compute(params, i0, X, T, U, mode);
    params.N = 2 * params.N;
elseif mode == 2
    if i0 == -1
        disp("Для улучшения нужно ранее найденное решение");
    else
        params.dphi = params.dphi / params.N;
        [X, T, U, i0, params.phi0, params.T] = compute(params, i0, {}, {}, {}, mode);
    end
else
    disp('Неверный ввод');
end
if i0 == -1
    disp("Задача быстродействия неразрешима");
else
    fprintf('Задача быстродействия решена с приближенным временем быстродействия T = %f\n', params.T);
end
%% plot
% Вывод графиков

captions = 0;
pparams = init_plot_params();

figure('Name','Задача быстродействия','NumberTitle','off');
if (pparams.axes == 0) || (pparams.axes == 1)
    if pparams.axes == 0
        pparams.show_all = 1;
        subplot(2,4,1);
    end
    [Xg, Yg] = meshgrid(linspace(-3, 3, 1000));
    Zg(1, :, :) = shiftdim(Xg, -1);
    Zg(2, :, :) = shiftdim(Yg, -1);
    contourf(Xg, Yg, -shiftdim(difference(Zg, params), 1), [0, 0]);
    hold on;
    plot(params.x1(1), params.x1(2), 'bo', 'MarkerSize', 7, 'MarkerFaceColor', 'b');
    if pparams.show_all == 1
        for i = 1:size(X, 2)
            if i ~= i0
                Xi = X{i};
                plot(Xi(:, 1), Xi(:, 2), 'k');
            end
        end
    end
    if i0 ~= -1
        Xi = X{i0};
        p = plot(Xi(:, 1), Xi(:, 2), 'r');
        p.LineWidth = 2;
        x = Xi(1, :);
        nphi = x(3:4) ./ sqrt(x(3) ^ 2 + x(4) ^ 2);
        p = quiver(x(1), x(2), nphi(1), nphi(2), "r");
        p.LineWidth = 2;
        count = 0;
        if almost_equal((x(1) - params.alpha) ^ 2 + (x(2) - params.beta) ^ 2, params.gamma) %% круг
            norm = sqrt((x(1) - params.alpha) ^ 2 + (x(2) - params.beta) ^ 2);
            n = [(x(1) - params.alpha), (x(2) - params.beta)] / norm;
            p = quiver(x(1), x(2), n(1), n(2), 'color', [0 0.5 0]);
            p.LineWidth = 2;
            fprintf("Проверка УТ0 (косинус между нормалью и вектором сопряженных переменных): %f\n", dot(nphi, n));
            count = count + 1;
        end
        if almost_equal(abs(x(1)) + abs(x(2)), params.r) %% эллипс
            n = [sign(x(1)), sign(x(2))];
            p = quiver(x(1), x(2), n(1), n(2), 'color', [0 0.5 0]);
            p.LineWidth = 2;
            fprintf("Проверка УТ0 (косинус между нормалью и вектором сопряженных переменных): %f\n", dot(nphi, n));
            count = count + 1;
        end
        if count == 2
            disp("Траектория попала на излом границы");
        end
    end
    hold off;
    axis([-3 3 -3 3]);
    axis square;
    disp("Красным выделена оптимальная траектория. Зеленой стрелкой указана нормаль в начальной точке,");
    disp("а красной - нормированный вектор сопряженных переменных");
    xlabel("$x_1$",'Interpreter','latex');
    ylabel("$x_2$",'Interpreter','latex');
    if captions
        title("Фазовый портрет",'Interpreter','latex');
    end
end
if (pparams.axes == 0) || (pparams.axes == 2)
    if pparams.axes == 0
        subplot(2,4,2);
    end
    patch([-1, 0, 1, 0, -1], [1, 1, 0, -1, -1], "c");
    hold on;
    if (i0 ~= -1) && (size(U, 2) > 0)
        Ui = U{i0};
        plot(Ui(1, :), Ui(2, :), 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
    end
    axis([-3 3 -3 3]);
    axis square;
    xlabel("$u_1$",'Interpreter','latex');
    ylabel("$u_2$",'Interpreter','latex');
    if captions
        title("Значения оптимального управления",'Interpreter','latex');
    end
end
if (pparams.axes == 0) || (pparams.axes == 3)
    if pparams.axes == 0
        subplot(2,4,3);
    end
    if i0 ~= -1
        Ti = T{i0};
        Xi = X{i0};
        plot(Ti, Xi(:, 1), "k");
        xlabel("$t$",'Interpreter','latex');
        ylabel("$x_1$",'Interpreter','latex');
        if captions
            title("График $x_1$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end
if (pparams.axes == 0) || (pparams.axes == 4)
    if pparams.axes == 0
        subplot(2,4,4);
    end
    if i0 ~= -1
        Ti = T{i0};
        Xi = X{i0};
        plot(Ti, Xi(:, 2), "k");
        xlabel("$t$",'Interpreter','latex');
        ylabel("$x_2$",'Interpreter','latex');
        if captions
            title("График $x_2$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end

if (pparams.axes == 0) || (pparams.axes == 5)
    if pparams.axes == 0
        subplot(2,4,5);
    end
    if i0 ~= -1
        Ti = T{i0};
        Xi = X{i0};
        plot(Ti, Xi(:, 3), "k");
        xlabel("$t$",'Interpreter','latex');
        ylabel("$\psi_1$",'Interpreter','latex');
        if captions
            title("График $\psi_1$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end

if (pparams.axes == 0) || (pparams.axes == 6)
    if pparams.axes == 0
        subplot(2,4,6);
    end
    if i0 ~= -1
        Ti = T{i0};
        Xi = X{i0};
        plot(Ti, Xi(:, 4), "k");
        xlabel("$t$",'Interpreter','latex');
        ylabel("$\psi_2$",'Interpreter','latex');
        if captions
            title("График $\psi_2$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end

if (pparams.axes == 0) || (pparams.axes == 7)
    if pparams.axes == 0
        subplot(2,4,7);
    end
    if (i0 ~= -1) && (size(U, 2) > 0)
        Ti = T{i0};
        Ui = U{i0};
        plot(Ti, Ui(1, :), "k");
        axis([0 Ti(end) -1.2 1.2]);
        xlabel("$t$",'Interpreter','latex');
        ylabel("$u_1$",'Interpreter','latex');
        if captions
            title("График $u_1$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end

if (pparams.axes == 0) || (pparams.axes == 8)
    if pparams.axes == 0
        subplot(2,4,8);
    end
    if (i0 ~= -1) && (size(U, 2) > 0)
        Ti = T{i0};
        Ui = U{i0};
        plot(Ti, Ui(2, :), "k");
        axis([0 Ti(end) -1.2 1.2]);
        xlabel("$t$",'Interpreter','latex');
        ylabel("$u_2$",'Interpreter','latex');
        if captions
            title("График $u_2$ оптимальной траектории",'Interpreter','latex');
        end
    elseif pparams.axes ~= 0
        disp("Решение не найдено")
    end
end
set(gcf,'renderer','painters');

%% functions

function [X, T, U, i0, phi0, T1] = compute(params, i0, X0, T0, U0, mode) % нахождение всех подозрительных траекторий и всего сопутствующего
    phi0 = -1;
    tspan = linspace(params.t0 + params.T, params.t0, 10000);
    x1(1:2) = params.x1;
    opts = odeset("Events", @(t, x) collision(t, x, params), 'RelTol', 1e-7, 'AbsTol', 1e-9, 'MaxStep', 1e-3);
    if ~any(params.B(:))
        disp("Матрица B нулевая, решение не зависит от управления!");
        x1(3:4) = [0; 0];
        [Ti, Xi] = ode45(@(t, x) odefunc(t, x, params), tspan, x1, opts);
        dT = Ti(1) - Ti(end);
        T1 = params.T;
        if dT < T1
            i0 = 1;
            T1 = dT;
        else
            disp("Решение не найдено");
        end
        T{1} = flip(Ti) - Ti(end);
        X{1} = flip(Xi);
        U = {};
        phi0 = 0;
        return;
    end
    if i0 == -1
        i = 1;
        di = 1;
        X = {};
        T = {};
    end
    if mode == 0
        phispace = 0:2*pi/params.N:2*pi/params.N*(params.N-1);
    elseif mode == 1
        for i = 1:params.N
            X{2*i-1} = X0{i};
            T{2*i-1} = T0{i};
            U{2*i-1} = U0{i};
        end
        i = 2;
        di = 2;
        i0 = 2*i0 - 1;
        phispace = (0:2*pi/params.N:2*pi*(params.N-1)/params.N) + pi/params.N;
        params.N = 2 * params.N;
    elseif mode == 2
        i = 1;
        di = 1;
        X = {};
        T = {};
        phispace = (params.phi0 - params.dphi*(params.N)):params.dphi:(params.phi0 + params.dphi*(params.N));
    end
    T1 = params.T;
    for phi = phispace
        x1(3:4) = [cos(phi); sin(phi)];
        [Ti, Xi] = ode45(@(t, x) odefunc(t, x, params), tspan, x1, opts);
        dT = Ti(1) - Ti(end);
        T{i} = flip(Ti) - Ti(end);
        X{i} = flip(Xi);
        Ui = zeros(2, size(Xi, 1));
        for j = 1:size(Xi, 1)
            [~, Ui(:, j)] = rhoP(params.B.' * Xi(j, 3:4).');
        end
        U{i} = Ui;
        if dT < T1
            T1 = dT;
            %tspan = linspace(params.t0 + T1, params.t0, 1000);
            i0 = i;
            phi0 = phi;
        end
        i = i + di;
    end
    if i0 == -1
        disp("Решение не найдено");
    end
end

function f = almost_equal(x, y)
    f = abs(x - y) <= 1e-9;
end

function [value, isterminal, direction] = collision(~, x, params) % ивент попадания в начальное множество 
    value = difference(x, params);
    isterminal = 1;
    direction = 0;
end

function y = difference(x, params) % псевдо расстояние до начального множества
    y = max((x(1, :, :) - params.alpha) .^ 2 + (x(2, :, :) - params.beta) .^ 2 - params.gamma, abs(x(1, :, :)) + abs(x(2, :, :)) - params.r);
end

function y = ind0(l, params) % индикатор ромба для опорного вектора круга
    if abs(params.alpha + params.gamma*l(1)/vecnorm(l)) + abs(params.beta + params.gamma*l(2).vecnorm(l)) <= params.r
        y = 1;
    else
        y = 0;
    end
end

function y = ind1(l, params) % индикатор круга для опорного вектора ромба
    if (params.r*sign(l(1)) - params.alpha)^2 + (params.r*sign(l(2)) - params.beta)^2 <= params.gamma
        y = 1;
    else
        y = 0;
    end
end

function y = rho00(l, params) % Опорная функция круга
    y = params.alpha * l(1) + params.beta * l(2) + params.gamma * vecnorm(l);
end

function y = rho01(l, params) % Опорная функция ромба
    y = params.r * max(abs(l(1)), abs(l(2)));
end

function y = rho0(l, params, points) % Опорная функция начального множества
    y = max([rho00(l, params) * ind0(l, params), rho01(l, params) * ind1(l, params), max(dot(repmat(l, 1, size(points, 2)), points))]);
end

function y = rho1(l, params) % Опорная функция конечного множества
    y = dot(l, params.x1);
end

function [y, x] = rhoP(l) % Опорная функция множества допустимых значений управления
    [y, i] = max([-l(1) + l(2), l(2), l(1), -l(2), -l(1) - l(2)]);
    p = [-1, 0, 1, 0, -1; 1, 1, 0, -1, -1];
    x = p(:, i);
end

function dx = odefunc(~, x, params) % правая часть объединенной системы
    % x = [x1, x2, psi1, psi2]
    dx = [0; 0; 0; 0];
    [~, u] = rhoP(params.B.' * x(3:4));
    dx(1:2) = params.A * x(1:2) + params.B * u + params.f;
    dx(3:4) = -params.A.' * x(3:4);
end

function points = get_points(params) % вычисление точек пересечения границ круга и ромба
    syms x y;
    eqn1 = (x - params.alpha) ^ 2 + (y - params.beta) ^ 2 == params.gamma;
    eqn2 = sqrt(x^2) + sqrt(y^2) == params.r; % если поставить модули, то матлаб почему-то не хочет нормально решать
    eqns = [eqn1, eqn2];
    S = solve(eqns, "Real", true);
    px = double(S.x);
    py = double(S.y);
    if (size(px, 1) == 0)
        points = [];
    end
    for i = 1:size(px, 1)
        points(1, i) = px(i);
        points(2, i) = py(i);
    end
end

function pparams = init_plot_params() % параметры для графика
    pparams = struct;
    pparams.axes = input('Выберите, в каких осях отображать график (число от 0 до 8): 0. Вывести все оси 1. (x1, x2) 2. (u1, u2)\n 3. (t, x1) 4. (t, x2) 5. (t, psi1) 6. (t, psi2), 7. (t, u1) 8. (t, u2)\n');
    while ~ismember(pparams.axes, 0:8)
        pparams.axes = input('Выберите, в каких осях отображать график (число от 0 до 8): 0. Вывести все оси 1. (x1, x2) 2. (u1, u2)\n 3. (t, x1) 4. (t, x2) 5. (t, psi1) 6. (t, psi2), 7. (t, u1) 8. (t, u2)\n');
    end
    if pparams.axes == 1
        pparams.show_all = input('Отображать все траектории (1) или только оптимальную (0)?\n');
        while (pparams.show_all ~= 0) && (pparams.show_all ~= 1)
            pparams.show_all = input('Отображать все траектории (1) или только оптимальную (0)?\n');
        end
    end
end

function params = init_params() % параметры задачи
    params = struct;
    mode = input('Введите 0 для ручного ввода параметров или 1-7 для выбора соответствующего примера\n');
    if mode == 0
        params.alpha = input('Введите параметр alpha\n');
        while ~isequal(size(params.alpha), [1 1])
            params.alpha = input('Введите параметр alpha\n');
        end
        params.beta = input('Введите параметр beta\n');
        while ~isequal(size(params.beta), [1 1])
            params.beta = input('Введите параметр beta\n');
        end
        params.gamma = input('Введите параметр gamma > 0\n');
        while ~isequal(size(params.gamma), [1 1]) || (params.gamma <= 0)
            params.gamma = input('Введите параметр gamma > 0\n');
        end
        params.r = input('Введите параметр r > 0\n');
        while ~isequal(size(params.r), [1 1]) || (params.r <= 0)
            params.r = input('Введите параметр r > 0\n');
        end
        params.x1 = input('Введите вектор x1 2x1 в виде [x1; x2]\n');
        while ~isequal(size(params.x1), [2 1])
            params.x1 = input('Введите вектор x1 2x1 в виде [x1; x2]\n');
        end
        params.t0 = input('Введите параметр t0\n');
        while ~isequal(size(params.t0), [1 1])
            params.t0 = input('Введите параметр t0\n');
        end
        params.T = input('Введите параметр T > 0\n');
        while ~isequal(size(params.T), [1 1]) || (params.T <= 0)
            params.T = input('Введите параметр T > 0\n');
        end
        params.A = input('Введите матрицу A 2x2 в виде [a1, a2; a3, a4]\n');
        while ~isequal(size(params.A), [2 2])
            params.A = input('Введите матрицу A 2x2 в виде [a1, a2; a3, a4]\n');
        end
        params.B = input('Введите матрицу B 2x2 в виде [b1, b2; b3, b4]\n');
        while ~isequal(size(params.B), [2 2])
            params.B = input('Введите матрицу B 2x2 в виде [b1, b2; b3, b4]\n');
        end
        params.f = input('Введите вектор f 2x1 в виде [f1; f2]\n');
        while ~isequal(size(params.f), [2 1])
            params.f = input('Введите вектор f 2x1 в виде [f1; f2]\n');
        end
        params.N = input('Введите начальное число перебираемых значений сопряженной переменной N > 0\n');
        while ~isequal(size(params.N), [1 1]) || (params.N <= 0)
            params.N = input('Введите начальное число перебираемых значений сопряженной переменной N > 0\n');
        end
    elseif (mode >= 1) && (mode <= 7) % Примеры
        if mode == 1 
            params.alpha = 1;
            params.beta = 0;
            params.gamma = 1;
            params.r = 1;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [0, 1; -1, 0];
            params.B = [1, 0; 0, 1];
            params.f = [0; 0];
            params.N = 20;
        elseif mode == 2
            params.alpha = 1;
            params.beta = 0;
            params.gamma = 1;
            params.r = 1;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [1, -1; -1, 1];
            params.B = [1, 2; 3, 4];
            params.f = [0; 0];
            params.N = 50;
        elseif mode == 3
            params.alpha = 0;
            params.beta = 0;
            params.gamma = 1;
            params.r = 1.3;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [1, 10; -10, 1];
            params.B = [1, 0; 0, 1];
            params.f = [0; 0];
            params.N = 20;
        elseif mode == 4 
            params.alpha = 0;
            params.beta = 0;
            params.gamma = 10;
            params.r = 1.05;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [1, 11; -11, 1];
            params.B = [0, 0; 0, 0];
            params.f = [0; 0];
            params.N = 50;
        elseif mode == 5 % Нулевая матрица B
            params.alpha = 0;
            params.beta = 0;
            params.gamma = 1;
            params.r = 1.3;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [1, -1; -1, 1];
            params.B = [0, 0; 0, 0];
            params.f = [0; 0];
            params.N = 50;
        elseif mode == 6
            params.alpha = 1;
            params.beta = 1;
            params.gamma = 1;
            params.r = 1.3;
            params.x1 = [-1; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [0, 1; -1, 0];
            params.B = [0, 1; 1, 0];
            params.f = [1; 0];
            params.N = 10;
        elseif mode == 7
            params.alpha = 0;
            params.beta = 0;
            params.gamma = 1;
            params.r = 1.3;
            params.x1 = [-2; 1];
            params.t0 = 0;
            params.T = 10;
            params.A = [0, 0.1; -0.1, 0];
            params.B = [1, 0; 0, 1];
            params.f = [0; 0];
            params.N = 50;
        end
        params.dphi = 2*pi/params.N;
    else 
        disp("Неверный ввод\n");
    end
end