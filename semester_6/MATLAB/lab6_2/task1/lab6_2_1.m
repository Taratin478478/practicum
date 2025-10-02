clc; close all; clear;

global g l m0 M umax T
g = 9.8;
l = 15;
m0 = 1000;
M = 500;
umax = 1000;
T = 0.8;
eps = 1e-3;

[t, y] = solve1();
if abs(y(end, 1)) > eps
    [t, y] = solve2();
end
plot_solution(t, y);

function [t, y] = solve1() % Случай 1 -- свободное время
    global g l m0 M umax T
    tspan = [0, T];
    y0 = [0, m0, 0];
    opts = odeset('Event', @no_fuel);
    [t1,y1] = ode45(@ode_system1, tspan, y0, opts);

    tspan = [t1(end), T];
    y0 = y1(end, :);
    opts = odeset('Event', @zero_speed);
    [t2,y2] = ode45(@ode_system2, tspan, y0, opts);
    t0 = [0; T-t2(end)];
    y0 = repmat([0, m0, 0], 2, 1);
    t = cat(1, t0, t1+(T-t2(end)), t2+(T-t2(end)));
    y = cat(1, y0, y1, y2);
end

function [t, y] = solve2() % Случай 2 -- фиксированное время
    global g l m0 M umax T
    tspan = [0, T];
    y0 = [0, m0, 0, T*g];
    opts = odeset('Event', @switch_fixed);
    [t1,y1] = ode45(@ode_system3, tspan, y0, opts);

    tspan = [t1(end), T];
    y0 = y1(end, 1:3);
    opts = odeset('Event', @zero_speed);
    [t2,y2] = ode45(@ode_system2, tspan, y0, opts);
    t = cat(1, t1, t2);
    y = cat(1, y1(:, 1:3), y2);
end

function plot_solution(t, y)
    figure("name", 'v');
    plot(t, y(:, 1));
    
    figure("name", 'm');
    plot(t, y(:, 2));

    figure("name", 'y');
    plot(t, y(:, 3));
end

function [position,isterminal,direction] = no_fuel(~, y)
    global M
    position = y(2) - M;
    isterminal = 1;
    direction = 0;
end

function [position,isterminal,direction] = zero_speed(~, y)
    position = y(1);
    isterminal = 1;
    direction = 0;
end

function [position,isterminal,direction] = switch_fixed(~, y)
    position = y(1) - y(4);
    isterminal = 1;
    direction = 0;
end

function dydt = ode_system1(~, y)
    global g l m0 M umax
    dydt = zeros(3, 1);
    dydt(1) = -g + (l + y(1))/y(2)*umax;      % v
    dydt(2) = -umax;                          % m
    dydt(3) = y(1);                           % y
end

function dydt = ode_system2(~, y)
    global g l m0 M umax
    dydt = zeros(3, 1);
    
    dydt(1) = -g;                             % v
    dydt(2) = 0;                              % m
    dydt(3) = y(1);                           % y
end

function dydt = ode_system3(~, y)
    global g l m0 M umax
    dydt = zeros(4, 1);
    dydt(1) = -g + (l + y(1))/y(2)*umax;      % v
    dydt(2) = -umax;                          % m
    dydt(3) = y(1);                           % y
    dydt(4) = -g;                             % w
end