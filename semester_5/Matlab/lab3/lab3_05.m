%% 5
clc;


record = false;
r = 5;
G = 2;
m1 = 2;
m2 = 8;
%m2 = 8;
x0 = [0; 1; 1; 0; 0; -1; -1; 0]; % x10, Vx10, y10, Vy10, x20, Vx20, y20, Vy20
N = 2000;
T = 10;

opts = odeset("Events", @(t, x) BounceEvent(t, x, r), 'MaxStep',0.1);
fig = figure();
fig.WindowState = 'maximized';
if record
    v = VideoWriter('animation3_05.avi');
    open(v);
end

[t, x] = ode45(@(t, x) ODESys(t, x, G, m1, m2), linspace(0, T, N), x0);
for i = 1:size(t)
    plot(x(i, 1), x(i, 3), 'ro', 'MarkerSize', 10 * sqrt(m1), 'MarkerFaceColor', 'r');
    hold on;
    plot(x(1:i, 1), x(1:i, 3), 'r');
    plot(x(i, 5), x(i, 7), 'bo', 'MarkerSize', 10 * sqrt(m2), 'MarkerFaceColor', 'b');
    plot(x(1:i, 5), x(1:i, 7), 'b');
    hold off;
    axis([-r r -r r]);
    axis square;
    
    if record
        frame = getframe(fig);
        writeVideo(v, frame);
    end
    pause(1/60);
end

if record
    close(v);
end

function dx = ODESys(~, x, G, m1, m2)
    r = norm([x(1), x(3)] - [x(5), x(7)]) ^ 3;
    dx = zeros(8, 1);
    dx(1) = x(2);
    dx(2) = G * m2 * (x(5) - x(1)) / r;
    dx(3) = x(4);
    dx(4) = G * m2 * (x(7) - x(3)) / r;
    dx(5) = x(6);
    dx(6) = G * m1 * (x(1) - x(5)) / r;
    dx(7) = x(8);
    dx(8) = G * m1 * (x(3) - x(7)) / r;
end