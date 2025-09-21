%% Исследование производной
clc; clear; close all;

syms u(r);
syms g(r);
u(r) = sqrt(lambertw(4*r^3*exp(4*r))/(4*r));
g(r) = (1/2)*sqrt(r/u(r))*(1-4*r*u(r)^2)*exp(r*(1-u(r)^2));
dg = diff(g, r)
S = solve(dg == 0)
%S = solve(dg == Inf)
S = solve(g == -1)
%fplot(dg);
%fplot(g);
fplot(u, [0, 20]);
%% Бифуркационная диаграмма
clc; clear; close all;

u0 = 0.05;
N0 = 1000;
N1 = 200;
figure;
hold on;
vals = zeros(1, N1);
for r = 0.002:0.002:3
    u = u0;
    for i = 1:N0
        u = f(r, u);
    end
    for i = 1:N1
        u = f(r, u);
        vals(i) = u;
    end
    scatter(ones(1, N1) * r, vals, 10, 'k', 'filled');
end
xlabel("r");
ylabel("u");
hold off;

%% Показатель Ляпунова
clc; clear; close all;

u0 = 0.05;
N = 1000;
RN = 1000;
R = linspace(0.01, 3, RN);
S = zeros(1, RN);

i = 0;
for r = R
    i = i + 1;
    u = u0;
    s = 0;
    for m = 1:N
        u = f(r, u);
        s = s + log(abs(df(r, u)));
    end
    S(i) = s / N;
end

plot(R, S);
grid on;
xlabel("r");
ylabel("p");

%% Мультипликаторы (символьно)

syms r
syms u;
u = sqrt(lambertw(4*r^3*exp(4*r))/(4*r));
J = [1/2*sqrt(r/u)*exp(r*(1-u^2)), -2*r*u*sqrt(r*u)*exp(r*(1-u^2)); 1, 0];
vals = eig(J);
fplot(vals)

%% Мультипликаторы (численно)
clc; clear; close all;

RN = 1000;
R = linspace(0.001, 1.5, RN);
mu = zeros(2, RN);
i = 0;
for r = R
    i = i + 1;
    u = sqrt(lambertw(4*r^3*exp(4*r))/(4*r));
    J = [1/2*sqrt(r/u)*exp(r*(1-u^2)), -2*r*u*sqrt(r*u)*exp(r*(1-u^2)); 1, 0];
    eig(J)
    abs(eig(J))
    mu(:, i) = abs(eig(J));
    if mu(1, i) > 1
        disp(r);
    end
end
plot(R, mu);
legend('|\mu_1|', '|\mu_2|', 'Location', 'southeast');
xlabel("r");
ylabel("$|\mu|$",'Interpreter','latex');

%% Бифуркация Неймарка-Сакера
clc; clear; close all;

N = 1000;
n = 20;
d = 0.01;
figure;
r = 0.7;
u0 = sqrt(lambertw(4*r^3*exp(4*r))/(4*r))
plot(u0, u0, 'r*')
hold on;
for phi = linspace(0, 2*pi*(N-1)/N, N)
    cur_u = u0 + d * cos(phi);
    cur_v = u0 + d * sin(phi);
    u = zeros(1, N);
    v = zeros(1, N);
    for i = 1:N
        next_u = F(r, cur_u, cur_v);
        next_v = cur_u;
        cur_u = next_u;
        cur_v = next_v;
        u(i) = cur_u;
        v(i) = cur_v;
    end
end
scatter(u, v, 10, 'k', 'filled');
xlabel("u");
ylabel("v");
hold off;

%% Пример 1

r = 0.2;
u0 = 0.05;
X = 0.5;
plot_system(r, u0, X);

%% Пример 2

r = 0.7;
u0 = 0.2;
X = 1;
plot_system(r, u0, X);

%% Пример 3

r = 1;
u0 = 0.2;
X = 2;
plot_system(r, u0, X);
u = sqrt(lambertw(4*r^3*exp(4*r))/(4*r))
df(r, u)

%% Пример 4
clc; clear; close all;
u0 = 0.05;
N0 = 1000;
N1 = 200;

r = 1;
u = u0;
for i = 1:N0
    u = f(r, u);
end
for i = 1:N1
    u = f(r, u);
    vals(i) = u;
end

vals
plot_system(r, u, 2);
df(r, vals(end))*df(r, vals(end-1))

%% Пример 5
clc; clear; close all;
u0 = 0.05;
N0 = 1000;
N1 = 200;

r = 1.35;
u = u0;
for i = 1:N0
    u = f(r, u);
end
for i = 1:N1
    u = f(r, u);
    vals(i) = u;
end

vals
plot_system(r, u, 2.5);
df(r, vals(end))*df(r, vals(end-1))*df(r, vals(end-2))

%% Пример 6

u0 = 0.05;
v0 = 1;
r = 0.6;

Plot_system(r, u0, v0);

%% Пример 7

u0 = 0.7;
v0 = 0.7;
r = 1.4;

Plot_system(r, u0, v0);

%% Пример 8

%%

function plot_system(r, u0, X)
    figure();
    x = linspace(0, X, 1000);
    plot(x, x,'LineWidth', 2);
    hold on;
    plot(x, f(r, x),'LineWidth', 2);
    u_cur = u0;
    for i = 1:10
        u_next = f(r, u_cur);
        quiver(u_cur, u_next, u_next - u_cur, 0, 'k', 'LineWidth', 1, 'AutoScale', 'off');
        quiver(u_next, u_next, 0, f(r, u_next) - u_next, 'k', 'LineWidth', 1, 'AutoScale', 'off');
        u_cur = u_next;
    end
    disp(u_cur);
    disp(df(r, u_cur));
    legend('y = x','y = f(x)', 'Location', 'southeast');
    xlabel("x");
    ylabel("y");
    hold off;
end

function Plot_system(r, u0, v0)
    figure();
    u_cur = u0;
    v_cur = v0;
    hold on;
    for i = 1:20
        u_next = f(r, u_cur);
        v_next = u_cur;
        quiver(u_cur, v_cur, u_next - u_cur, v_next - v_cur, 'k', 'LineWidth', 1, 'AutoScale', 'off');
        u_cur = u_next;
        v_cur = v_next;
    end
    xlabel("u");
    ylabel("v");
    disp(u_cur);
    disp(v_cur);
    u = sqrt(lambertw(4*r^3*exp(4*r))/(4*r));
    disp(u);
    plot(u, u, 'ro','MarkerSize',7,'MarkerFaceColor','r');
    %axis([-M M -M M]);
    hold off;
end

function y = f(r, u)
    y = sqrt(r*u).*exp(r*(1-u.^2));
end

function y = df(r, u)
    y = (1/2)*sqrt(r/u)*(1-4*r*u^2)*exp(r*(1-u^2));
end

function y = F(r, u, v)
    y = sqrt(r*u).*exp(r*(1-v.^2));
end

function draw_marker(x, y)

    hold on

    plot(x, y, 'b*')

    plot([0, x], [y, y], 'k-.')
    plot([x, x], [0, y], 'k-.')

end
