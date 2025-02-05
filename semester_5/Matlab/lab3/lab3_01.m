%%1

a = -3;
b = 3;
N = 1000;
f1 = @(x) sec(x);
f2 = @(x) x.^3 + x - 1;

x = linspace(a, b, N);
fig = figure();
fig.WindowState = 'maximized';
plot(x, f1(x));
hold on;
plot(x, f2(x));
axis([a b -10, 10]);
hold off;

n = 3333;
for i = 1:n
    [x0, y0] = ginput(1);
    disp(["Начальное приближение: ", x0]);
    hold on;
    plot(x0, y0, 'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b');
    %opt = optimset('FunValCheck', 'on', 'Display','iter');
    x1 = fzero(@(x) f1(x) - f2(x), x0);
    if abs(f1(x1) - f2(x1)) > 1
        fprintf("Найденное значение не является корнем: abs(f1(x) - f2(x)) = %f\n\n", abs(f1(x1) - f2(x1)));
    else
        plot(x1, f2(x1), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    end
    hold off;
    disp(["Найденный корень: ", x1]);
    disp(["Невязка: ", abs(x0 - x1)]);
end
