%% 2

a = 10;
N = 10000;
x = linspace(-a, a, N);

fig = figure();
fig.WindowState = 'maximized';
for i = 1:N
    y(i) = fzero(@f, x(i));
end
plot(x, y);
hold on;
plot(x, f(x))
hold off;


function y = f(x)
    if x == 0
        y = 0;
    else
        y = x .* cos(log(abs(x)));
    end
end