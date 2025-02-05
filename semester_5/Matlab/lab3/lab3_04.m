%% 4
clc;

record = false;
alpha = 2;
r = 2;
x0 = [0; 2; 0; -5]; % x0, Vx0, y0, Vy0
%x0 = [0; 2; 0; -10];
A = [0, 1, 0, 0; -alpha, 0, 0, 0; 0, 0, 0, 1; 0, 0, -alpha, 0];
N = 5000;
T = 100;
MaxBounces = 20;

opts = odeset("Events", @(t, x) BounceEvent(t, x, r), 'MaxStep',0.1);
fig = figure();
fig.WindowState = 'maximized';
if record
    v = VideoWriter('animation3_04.avi');
    open(v);
end

for j = 1:MaxBounces
    [t, x, ~, xb, event] = ode45(@(t, x) A * x, linspace(0, T, N), x0, opts);
    for i = 1:size(t)
        plot(x(1:i, 1), x(1:i, 3));
        hold on;
        plot(x(i, 1), x(i, 3), 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
        disp(x(i, :));
        hold off;
        axis([-r r -r r]);
        axis square;
        if record
            frame = getframe(fig);
            writeVideo(v, frame);
        end
        pause(1/60);
    end
    x0 = x(end, :);
    for ev = event
        if ev == 1
            x0(2) = -x0(2);
        end
        if ev == 2
            x0(4) = -x0(4);
        end
    end
end
if record
    close(v);
end

function [value, isterminal, direction] = BounceEvent(t, x, r)
    value = [1, 1];
    if t > 0.1
        value(1) = max(0, r - abs(x(1)));
        value(2) = max(0, r - abs(x(3)));
    end
    isterminal = [1, 1];
    direction = [0, 0];
end