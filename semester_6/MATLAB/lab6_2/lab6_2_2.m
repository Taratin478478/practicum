clc; close all; clear;

global g l m0 M umax T H alpha
g = 9.8;
l = 15;
m0 = 1000;
M = 500;
umax = 1000;
T = 0.8;
H = 1   ;
alpha = 1000;

max_err = 0.2;
N = 7;
N_iter = 3;
[t, y] =  solve_rocket(N, N_iter, max_err);

function plot_solution(t1, y1, t2, y2)
    figure("name", 'v');
    plot(t1, y1(:, 1));
    
    figure("name", 'm');
    plot(t1, y1(:, 2));

    figure("name", 'y');
    plot(t1, y1(:, 3));

    figure("name", 'psi1');
    plot(t2, y2(:, 4));

    figure("name", 'eta');
    plot(t2, y2(:, 5));

    figure("name", 'psi3');
    plot(t2, y2(:, 6));
end

function [t, y] = solve_rocket(N, N_iter, max_err)
    global g l m0 M umax T H alpha
    
    disp("Случай 1 --- свободное начальное время, топливо в конце не кончилось");
    try    
        step = T / N;
        [t0, t1, t2, err] = search1(0, T, 0, T, 0, T, N);

        for i = 1:N_iter-1
            step = step / N;
            [t0, t1, t2, err] = search1(t0 - N*step, t0 + N*step, t1 - N*step, t1 + N*step, t2 - N*step, t2 + N*step, N);
        end
        if err < max_err
            [t, y] = solve1(t0, t1, t2);
            return;
        end
    catch ME
    end
    
    disp("Случай 2 --- фиксированное начальное время, топливо в конце не кончилось");
    try
        step = T / N;
        [t1, t2, err] = search2(0, T, 0, T, N);

        for i = 1:N_iter-1
            step = step / N;
            [t1, t2, err] = search2(t1 - N*step, t1 + N*step, t2 - N*step, t2 + N*step, N);
        end
        if err < max_err
            [t, y] = solve1(0, t1, t2);
            return;
        end
    catch ME
    end
    
    disp("Случай 3 --- свободное начальное время, топливо в конце кончилось");
    try
        step = T / N;
        [t0, t1, t2, err] = search3(0, T, 0, T, 0, T, N);

        for i = 1:N_iter-1
            step = step / N;
            [t0, t1, t2, err] = search3(t0 - N*step, t0 + N*step, t1 - N*step, t1 + N*step, t2 - N*step, t2 + N*step, N);
        end
        if err < max_err
            [t, y] = solve1(t0, t1, t2);
            return;
        end
    catch ME
    end
    
    disp("Случай 4 --- фиксированное начальное время, топливо в конце кончилось");
    try 
        step = T / N;
        [t1, t2, err] = search4(0, T, 0, T, N);

        for i = 1:N_iter-1
            step = step / N;
            [t1, t2, err] = search4(t1 - N*step, t1 + N*step, t2 - N*step, t2 + N*step, N);
        end
        if err < max_err
            [t, y] = solve1(0, t1, t2);
            return;
        else
            disp("Решение с нужной точностью не найдено");
            t = [0];
            y = [0, 0, 0, 0, 0, 0];
        end
    catch ME
        disp("Решение с нужной точностью не найдено");
        t = [0];
        y = [0, 0, 0, 0, 0, 0];
    end
end

function [t0opt, t1opt, t2opt, errmin] = search1(l0, r0, l1, r1, l2, r2, N)
    global g l m0 M umax T H alpha
    step0 = (r0 - l0) / N;
    step1 = (r1 - l1) / N;
    step2 = (r2 - l2) / N;
    errmin = Inf;
    disp("      t0       t1       t2      y err      v err    eta err      m err  total err");
    for t0 = linspace(max(0, l0), r0-step0, N)
        for t1 = max(l1, t0+step1):step1:r1
            tspan = [t0 t1];
            y0 = [0; m0; 0];
            [~,y] = ode45(@ode_system1, tspan, y0);
            for t2 = max(l2, t1+step2):step2:r2
                tmesh = linspace(t1, t2, 20);
                solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
                sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions1(ya, yb, y(end, :), t2), solinit);
                err1 = sol.y(3, end) + (T - t2)*sol.y(1, end) - (T - t2)^2/2*g - H;
                err2 = sol.y(1, end) - (T - t2)*g;
                err3 = -sol.y(6, end)/sol.y(2, end)*(T - t2)*(l + (T - t2)*g) + alpha/2;
                err4 = max(0, M - sol.y(2, end));
                
                err1 = err1 * 2;
                err3 = err3 / alpha * 2;
                err4 = err4 / 10;
                
                err = norm([err1, err2, err3, err4]);
                if err < errmin
                    fprintf("%f %f %f %+10.6f %+10.6f %+10.6f %+10.6f %+10.6f\n\n", t0, t1, t2, err1, err2, err3, err4, err);
                    errmin = abs(err);
                    t0opt = t0;
                    t1opt = t1;
                    t2opt = t2;
                end 
                %figure;
                %plot(sol.x, sol.y(5, :));
                %fprintf("%f %f %f %f %f %f\n", t0, t1, t2, err, sol.y(3, end) - H + (T - t2)^2*g/2, sol.y(1, end) - (T - t2)*g);
                %fprintf("%f %f %f %f %f %f %f\n\n", t0, t1, t2, err1, err2, err3, err);
            end
        end
    end
end

function [t1opt, t2opt, errmin] = search2(l1, r1, l2, r2, N)
    global g l m0 M umax T H alpha
    t0 = 0;
    step1 = (r1 - l1) / N;
    step2 = (r2 - l2) / N;
    errmin = Inf;
    disp("      t1       t2      y err    eta err      m err  total err");
    
    
    for t1 = max(l1, t0+step1):step1:r1
        tspan = [t0 t1];
        y0 = [0; m0; 0];
        [~,y] = ode45(@ode_system1, tspan, y0);
        for t2 = max(l2, t1+step2):step2:r2
            tmesh = linspace(t1, t2, 20);
            solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
            sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions1(ya, yb, y(end, :), t2), solinit);
            err1 = sol.y(3, end) + (T - t2)*sol.y(1, end) - (T - t2)^2/2*g - H;
            err3 = -sol.y(6, end)/sol.y(2, end)*(T - t2)*(l + sol.y(1, end) - t2*g) + alpha/2;
            err4 = max(0, M - sol.y(2, end));
            
            err1 = err1 * 2;
            err3 = err3 / alpha * 2;
            err4 = err4 / M * 5;
            
            err = norm([err1, err3, err4]);
            if abs(err) < errmin
                fprintf("%f %f %+10.6f %+10.6f %+10.6f %+10.6f\n\n", t1, t2, err1, err3, err4, err);
                errmin = abs(err);
                t1opt = t1;
                t2opt = t2;
            end 
        end
    end
end

function [t0opt, t1opt, t2opt, errmin] = search3(l0, r0, l1, r1, l2, r2, N)
    global g l m0 M umax T H alpha
    step0 = (r0 - l0) / N;
    step1 = (r1 - l1) / N;
    step2 = (r2 - l2) / N;
    errmin = Inf;
    disp("      t0       t1       t2      y err      v err      m err  total err");
    for t0 = linspace(max(0, l0), r0-step0, N)
        for t1 = max(l1, t0+step1):step1:r1
            tspan = [t0 t1];
            y0 = [0; m0; 0];
            [~,y] = ode45(@ode_system1, tspan, y0);
            for t2 = max(l2, t1+step2):step2:r2
                tmesh = linspace(t1, t2, 20);
                solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
                sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions1(ya, yb, y(end, :), t2), solinit);
                err1 = sol.y(3, end) + (T - t2)*sol.y(1, end) - (T - t2)^2/2*g - H;
                err2 = sol.y(1, end) - (T - t2)*g;
                err3 = sol.y(2, end) - M;
                
                err1 = err1 * 2;
                err3 = err3 / 10;
                
                err = norm([err1, err2, err3]);
                if err < errmin
                    fprintf("%f %f %f %+10.6f %+10.6f %+10.6f %+10.6f\n\n", t0, t1, t2, err1, err2, err3, err);
                    errmin = abs(err);
                    t0opt = t0;
                    t1opt = t1;
                    t2opt = t2;
                end 
                %figure;
                %plot(sol.x, sol.y(5, :));
                %fprintf("%f %f %f %f %f %f\n", t0, t1, t2, err, sol.y(3, end) - H + (T - t2)^2*g/2, sol.y(1, end) - (T - t2)*g);
                %fprintf("%f %f %f %f %f %f %f\n\n", t0, t1, t2, err1, err2, err3, err);
            end
        end
    end
end

function [t1opt, t2opt, errmin] = search4(l1, r1, l2, r2, N)
    global g l m0 M umax T H alpha
    t0 = 0;
    step1 = (r1 - l1) / N;
    step2 = (r2 - l2) / N;
    errmin = Inf;
    disp("      t1       t2      y err    eta err      m err  total err");
    for t1 = max(l1, t0+step1):step1:r1
        tspan = [t0 t1];
        y0 = [0; m0; 0];
        [~,y] = ode45(@ode_system1, tspan, y0);
        for t2 = max(l2, t1+step2):step2:r2
            tmesh = linspace(t1, t2, 20);
            solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
            sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions1(ya, yb, y(end, :), t2), solinit);
            err1 = sol.y(3, end) + (T - t2)*sol.y(1, end) - (T - t2)^2/2*g - H;
            err3 = sol.y(2, end) - M;
            
            err1 = err1 * 2;
            
            err = norm([err1, err3]);
            if abs(err) < errmin
                fprintf("%f %f %+10.6f %+10.6f %+10.6f\n\n", t1, t2, err1, err3, err);
                errmin = abs(err);
                t1opt = t1;
                t2opt = t2;
            end 
        end
    end
end


function [tfull, yfull, tnf, ynf] = solve1(t0, t1, t2)
    global g l m0 M umax T H alpha
    N0 = 100;
    tspan = [t0 t1];
    y0 = [0; m0; 0];
    [t,y] = ode45(@ode_system1, tspan, y0);
    %plot(t, y(:, 2));
    if (t1~=t2)
        tmesh = linspace(t1, t2, N0);
        solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
        try
            sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions1(ya, yb, y(end, :), t2), solinit);
        catch ME
            disp(ME);
        end
        y0 = sol.y(:, end);
        t1 = sol.x(2:end-1)';
    else
        y0 = y(end, :);
        t1 = [];
    end

    tspan = [t2 T];

    [t23,y23] = ode45(@ode_system3, tspan, y0);

    tfull = [t; t1; t23];   
    psi01 = [ones(size(t,1), 1)*sol.y(4, 1), ones(size(t,1), 1)*sol.y(5, 1), ones(size(t,1), 1)*sol.y(6, 1)];
    y01 = cat(2, y, psi01);
    yfull = cat(1, y01, sol.y(:, 2:end-1)', y23);
    tnf = [t1; t23];
    ynf = cat(1, sol.y(:, 2:end-1)', y23);
    plot_solution(tfull, yfull, tnf, ynf);
end

%{
function g = guess2(t, y0)
    g(1) = t;
    g(2) = t;
    g(3) = t;
    g(4) = t;
    g(5) = t;
    g(6) = ones(size(t, 1));
end
%}

function g = guess2(t, y0)
    global umax
    g(1) = y0(1) + t;
    g(2) = y0(2)*ones(size(t, 1));
    g(3) = y0(3) + t;
    g(4) = 10*ones(size(t, 1));
    g(5) = umax*(t(end) - t)./t(end);
    g(6) = ones(size(t, 1));
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
    dydt = zeros(6, 1);
    
    dydt(1) = -g + (l + y(1))/y(2)*y(5);      % v
    dydt(2) = -y(5);                          % m
    dydt(3) = y(1);                           % y
    dydt(4) = -y(5)*y(4)/y(2) - y(6);         % psi1
    dydt(5) = -(y(6)*(l+y(1)) + y(4)*g)/y(2); % eta
    dydt(6) = 0;                              % psi3
end

function dydt = ode_system3(~, y)
    global g l m0 M umax
    dydt = zeros(6, 1);
    
    dydt(1) = -g;                             % v
    dydt(2) = 0;                              % m
    dydt(3) = y(1);                           % y
    dydt(4) = - y(6);                         % psi1
    dydt(5) = -(y(6)*(l+y(1)) + y(4)*g)/y(2); % eta
    dydt(6) = 0;                              % psi3
end



function res = boundary_conditions1(ya, yb, y0, t2)
    global g umax T H
    res = zeros(6, 1);

    res(1) = ya(1) - y0(1); 
    res(2) = ya(2) - y0(2);
    res(3) = ya(3) - y0(3);
    %res(4) = yb(3) - H + (T - t2)^2*g/2;
    %res(5) = yb(1) - (T - t2)*g;
    res(6) = yb(4) - (T - t2)*ya(6);
    res(4) = ya(5) - umax;
    res(5) = yb(5);
    %res(6) = umax^2/2 + (yb(4)-ya(4))*g+(ya(1)-yb(1))*ya(6);
end


%{


    disp("Случай 2.2 --- фиксированное начальное время, топливо в конце не кончилось, не было отключения двигателей");
    
    stept = T / N;
    stepeta = umax / N;
    [t1, eta, err] = search22(0, T, M, m0, N);
    
    for i = 1:N_iter-1
        stept = stept / N;
        stepeta = stepeta / N;
        [t1, eta, err] = search22(t1 - N*stept, t1 + N*stept, eta - N*stepeta, eta + N*stepeta, N);
    end
    disp([t1, eta, err]);
    if err < max_err
        [t, y] = solve22(t1, eta);
        return;
    end


function [t1opt, etaopt, errmin] = search22(l1, r1, l2, r2, N)
    global g l m0 M umax T H alpha
    t0 = 0;
    step1 = (r1 - l1) / N;
    step2 = (r2 - l2) / N;
    errmin = Inf;
    disp("      t1      eta      y err        err");
    for t1 = max(l1, t0+step1):step1:min(r1, T - step1)
        tspan = [t0 t1];
        y0 = [0; m0; 0];
        [~,y] = ode45(@ode_system1, tspan, y0);
        
        for eta = l2:step2:r2
            tmesh = linspace(t1, T, 20);
            solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
            sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions22(ya, yb, y(end, :), eta), solinit);
            err1 = sol.y(3, end) - H;
            
            err = err1;
            if abs(err) < errmin
                fprintf("%f %f %+10.6f %+10.6f\n\n", t1, eta, err1, err);
                errmin = abs(err);
                t1opt = t1;
                etaopt = eta;
            end 
        end
    end
end

function [tfull, yfull] = solve22(t1, eta)
    global g l m0 M umax T H alpha
    N0 = 100;
    tspan = [0 t1];
    y0 = [0; m0; 0];
    [t,y] = ode45(@ode_system1, tspan, y0);
    %plot(t, y(:, 2));

    tmesh = linspace(t1, T, N0);
    solinit = bvpinit(tmesh, @(t) guess2(t, y(end, :)));
    try
        sol = bvp4c(@ode_system2, @(ya, yb) boundary_conditions22(ya, yb, y(end, :), eta), solinit);
    catch ME
        disp(ME);
    end

    tfull = [t; sol.x(2:end)'];
    psi01 = [ones(size(t,1), 1)*sol.y(4, 1), ones(size(t,1), 1)*sol.y(5, 1), ones(size(t,1), 1)*sol.y(6, 1)];
    y01 = cat(2, y, psi01);
    yfull = cat(1, y01, sol.y(:, 2:end)');
end


function res = boundary_conditions22(ya, yb, y0, eta)
    global umax
    res = zeros(6, 1);

    res(1) = ya(1) - y0(1); 
    res(2) = ya(2) - y0(2);
    res(3) = ya(3) - y0(3);
    %res(4) = yb(3) - H + (T - t2)^2*g/2;
    %res(5) = yb(1) - (T - t2)*g;
    res(6) = ya(5) - umax;
    res(4) = yb(5) - eta;
    res(5) = yb(4);
    %res(6) = umax^2/2 + (yb(4)-ya(4))*g+(ya(1)-yb(1))*ya(6);
end
%}