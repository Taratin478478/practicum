
%% 6
f = @(x) -x.^2 - x.^3;
x = linspace(-2, 2, 1000);
y = f(x);
plot(x, y);
hold on;
plot(x(islocalmin(y)), y(islocalmin(y)), 'bo', 'MarkerSize',8, 'MarkerFaceColor', 'b');
[maxy, ind] = max(y);
maxx = x(ind);
plot(maxx, maxy,'ro','MarkerSize',8, 'MarkerFaceColor', 'r');
[miny, ind] = min(abs(x(islocalmin(y)) - maxx));
mx = x(islocalmin(y));
minx = mx(ind);
space = linspace(maxx, minx, 500);
comet(space, f(space));
hold off;