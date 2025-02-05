clc; clear; close all;

R = 11;
eps = 1e-6;
n = 2;
%{
f = @(x) x(1)^2 + x(2)^2/2;
df = {@(x) 2 .* x(1), @(x) 1 .* x(2)};
x0 = [2; 3];
%}


f = @(x) (x(1) -  1)^2 + (x(2) - 1)^2 + x(1) * x(2);
df = {@(x) 2 .* (x(1) - 1) + x(2), @(x) 2 .* (x(2) - 1) + x(1)};
x0 = [10; 10];

%{
f = @(x) (x(1) -  1)^2 + (x(2) - 1)^2 + x(1) * x(2) + x(3)^2;
df = {@(x) 2 .* (x(1) - 1) + x(2), @(x) 2 .* (x(2) - 1) + x(1), @(x) 2 * x(3)};
x0 = [10; 10; 10];
%}
f2 = f(x0);
f0 = Inf;
N = 100;


[X, Y] = meshgrid(linspace(-R, R, N));
Z = zeros(N, N);
for i = 1:N
    for j = 1:N
        Z(i, j) = f([X(i, j), Y(i, j)]);
    end
end
levels(1) = f(x0);

fig = figure();
fig.WindowState = 'maximized';
axis square;

hold on;

l = 1;
x1 = x0;
while abs(f2 - f0) > eps
    f0 = f(x1);
    for i = 1:n
        x2 = x1;
        x2(i) = fzero(@(xi) dfi(df{i}, x1, i, xi), x1(i));
        quiver(x1(1), x1(2), x2(1) - x1(1), x2(2) - x1(2));
        l = l + 1;
        levels(l) = f(x2);
        disp(x1);
        x1 = x2;
    end
    f2 = f(x2);
end

colormap([0, 0, 0]);
contour(X, Y, Z, levels);

hold off;

disp("answer:");
disp(x1);
fprintf("with presicion %f in %d steps\nf(x) = %.10f\n\n", eps, l - 1, f(x1));
x1 = fminsearch(f, x0);
disp("fminsearch solution:");
disp(x1);
fprintf("f(x) = %.10f\n", f(x1))

function y = dfi(df, x, i, xi)
    x(i) = xi;
    y = df(x);
end