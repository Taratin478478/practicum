%% 7
clc; clear; close all;

V1 = @(x, y) x.^2 + y.^2;
V2 = @(x, y) x.^2 + y.^4;

fig = figure();
fig.WindowState = 'maximized';
hold on;

colormap parula;
map = colormap;
colormap([0, 0, 0]);
T = 100;
N = 100;
RelTol = 1e-5;
AbsTol = 1e-7;


R = 2;
[X, Y] = meshgrid(linspace(-R, R, 100));
Pow = 0.1;
MaxLyap = 0;
MinLyap = Inf;
contour(X, Y, V1(X, Y));
x = [];
sizes = [];
nsz = 0;

disp(1);
r = 0.1;
R = 0.5;
opts = odeset("Events", @(t, x) Bounds(t, x, R));
for phi = linspace(0, 2*pi, 3)
    x0 = r * cos(phi);
    y0 = r * sin(phi);
    [t, x1] = ode45(@ODESys1, linspace(30, T, N), [x0; y0], opts);
    MaxLyap = max(MaxLyap, max(V1(x1(1:end-1, 1), x1(1:end-1, 2))));
    MinLyap = min(MinLyap, min(V1(x1(1:end-1, 1), x1(1:end-1, 2))));
    x = cat(1, x, x1);
    nsz = nsz + 1;
    sizes(nsz) = size(t, 1);
end

disp(2);
r = 0.5;
R = 2;
opts = odeset("Events", @(t, x) Bounds(t, x, R));
for phi = linspace(0, 2*pi, 20)
    x0 = r * cos(phi);
    y0 = r * sin(phi);
    [t, x1] = ode45(@ODESys1, linspace(30, T, N), [x0; y0], opts);
    MaxLyap = max(MaxLyap, max(V1(x1(:, 1), x1(:, 2))));
    MinLyap = min(MinLyap, min(V1(x1(:, 1), x1(:, 2))));
    x = cat(1, x, x1);
    nsz = nsz + 1;
    sizes(nsz) = size(t, 1);
end

k = 1;
for s = 1:nsz
    for d = 1:(sizes(s)-1)
        quiver(x(k, 1), x(k, 2), x(k + 1, 1) - x(k, 1), x(k + 1, 2) - x(k, 2), 'Color', map(max(1, ceil(norm(V1(x(k+1, 1), x(k+1, 2))^Pow - MinLyap^Pow) / (MaxLyap^Pow - MinLyap^Pow) * 64)), :));
        k = k + 1;
    end
    k = k + 1;
end

axis([-2 2 -2 2]);
axis square;







T = 30;

fig = figure();
fig.WindowState = 'maximized';
colormap([0, 0, 0]);
hold on;
R = 1.5;
ND = 7;
opts = odeset("Events", @(t, x) Bounds(t, x, R));
disp(3);

%{
[X, Y] = meshgrid([R], linspace(-R * (ND - 2) / ND, R * (ND - 2) / ND, ND));
MaxLyap = max(max(V2(X, Y)));
%}
[X, Y] = meshgrid(linspace(-R, R, 100));
contour(X, Y, V2(X, Y));
Pow = 0.1;
MaxLyap = 0;
MinLyap = Inf;
x = [];
sizes = [];
nsz = 0;

%{
y0 = R;
for x0 = linspace(-R, R, 5)
    disp([x0, y0]);
    [t, x] = ode45(@ODESys2, linspace(10, T, N), [x0; y0], opts);
    for k = 1:(size(t)-1)
        quiver(x(k, 1), x(k, 2), x(k + 1, 1) - x(k, 1), x(k + 1, 2) - x(k, 2));
    end
end
y0 = -R;
for x0 = linspace(-R, R, 5)
    disp([x0, y0]);
    [t, x] = ode45(@ODESys2, linspace(10, T, N), [x0; y0], opts);
    for k = 1:(size(t)-1)
        quiver(x(k, 1), x(k, 2), x(k + 1, 1) - x(k, 1), x(k + 1, 2) - x(k, 2));
    end
end
%}
x0 = R;
for y0 = linspace(-R * (ND - 2) / ND, R * (ND - 2) / ND, ND)
    disp([x0, y0]);
    [t, x1] = ode45(@ODESys2, linspace(10, T, N), [x0; y0], opts);
    MaxLyap = max(MaxLyap, max(V2(x1(:, 1), x1(:, 2))));
    MinLyap = min(MinLyap, min(V2(x1(:, 1), x1(:, 2))));
    x = cat(1, x, x1);
    nsz = nsz + 1;
    sizes(nsz) = size(t, 1);
end
x0 = -R;
for y0 = linspace(-R * (ND - 2) / ND, R * (ND - 2) / ND, ND)
    disp([x0, y0]);
    [t, x1] = ode45(@ODESys2, linspace(10, T, N), [x0; y0], opts);
    MaxLyap = max(MaxLyap, max(V2(x1(:, 1), x1(:, 2))));
    MinLyap = min(MinLyap, min(V2(x1(:, 1), x1(:, 2))));
    x = cat(1, x, x1);
    nsz = nsz + 1;
    sizes(nsz) = size(t, 1);
end

k = 1;
for s = 1:nsz
    for d = 1:(sizes(s)-1)
        quiver(x(k, 1), x(k, 2), x(k + 1, 1) - x(k, 1), x(k + 1, 2) - x(k, 2), 'Color', map(max(1, ceil(norm(V2(x(k + 1, 1), x(k + 1, 2))^Pow - MinLyap^Pow) / (MaxLyap^Pow - MinLyap^Pow) * 64)), :));
        k = k + 1;
    end
    k = k + 1;
end


axis([-R R -R R]);
axis square;
hold off;

function dx = ODESys1(~, x) % неуст
    dx = zeros(2, 1);
    dx(1) = x(1) ^ 3 - x(2);
    dx(2) = x(1) + x(2) ^ 3;
end

function dx = ODESys2(~, x) % уст
    dx = zeros(2, 1);
    dx(1) = 2 * x(2) ^ 3 - x(1) ^ 5;
    dx(2) = -x(1) - x(2) ^ 3 + x(2) ^ 5;
end


function [value, isterminal, direction] = Bounds(~, x, r)
    value = r - max(abs(x(1)), abs(x(2)));
    isterminal = 1;
    direction = 0;
end