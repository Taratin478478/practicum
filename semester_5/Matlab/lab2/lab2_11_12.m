%f = @(x, y, p) p .* sin(x) + (1-p) .* sin(y);
f = @(x, y, p) -p.*x.*y./5 + sin(p.*x.*y./2) + (2*p)^2 .* exp(-p.*(x.^2 + y.^2));
p1 = 0;
p2 = 2;
n = 30;
np = 50;
[x, y] = meshgrid(linspace(-2 * pi, 2 * pi, n), linspace(-2 * pi, 2 * pi, n));
%% 11

mov(1:np+1) = struct('cdata', [],'colormap', []);
k = 0;
%fig = figure();
%fig.WindowState = 'maximized';
for p = linspace(p1, p2, np)
    z = f(x, y, p);
    surf(x, y, z);
    hold on;
    axis([-2*pi 2*pi -2*pi 2*pi -16 16]);
    map = and(islocalmax(z, 1, 'FlatSelection','all'), islocalmax(z, 2, 'FlatSelection','all'));
    plot3(x(map), y(map), z(map), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r'); %plot local max
    map = and(islocalmin(z, 1, 'FlatSelection','all'), islocalmin(z, 2, 'FlatSelection','all'));
    plot3(x(map), y(map), z(map), 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b'); %plot local min
    hold off;
    mov(k+1) = getframe();
    k = k + 1;
end
%%
fig = figure();
clf(fig);
%fig.WindowState = 'maximized';
axis off;
movie(mov, 1, 60);
%%
p = 1;
z = f(x, y, p);
level = 1;
contour(x, y, z, [level, level]);
%% 12
save('animation2_12.mat', 'mov');
v = VideoWriter('animation2_12.avi');
open(v);
k = 0;
fig = figure();
fig.WindowState = 'maximized';
for p = linspace(p1, p2, np)
    z = f(x, y, p);
    surf(x, y, z);
    hold on;
    axis([-2*pi 2*pi -2*pi 2*pi -16 16]);
    map = and(islocalmax(z, 1, 'FlatSelection','all'), islocalmax(z, 2, 'FlatSelection','all'));
    plot3(x(map), y(map), z(map), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); %plot local max
    map = and(islocalmin(z, 1, 'FlatSelection','all'), islocalmin(z, 2, 'FlatSelection','all'));
    plot3(x(map), y(map), z(map), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b'); %plot local min
    hold off;
    frame = getframe(fig);
    writeVideo(v, frame);
    k = k + 1;
end
%writeVideo(v, mov);
close(v);
close(fig);
clearvars mov;
load('animation2_12.mat', 'mov');
movie(mov, 1, 60);
