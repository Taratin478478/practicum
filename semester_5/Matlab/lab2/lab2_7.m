%% 7
A = 1;
B = 1;
%a = 1;
%b = 2;
a = 2;
b = 3;
%a = 7;
%b = 11;
delta = 0;
f = @(t) A .* sin(a.*t + delta);
g = @(t) B .* sin(b.*t);
%g = @sin;
%f = @(t) t;
N = 10;
t0 = 0;
t1 = 2*pi;

tt = linspace(t0, t1, 1000);
plot(f(tt), g(tt), "-k", 'LineWidth', 3);
t = linspace(t0, t1, N);
hold on;
plot(f(t), g(t), "--bsquare", 'MarkerSize', 8, 'MarkerFaceColor', 'b');
disp("equal delta t");
disp(median(abs(diff(vecnorm(diff([f(t); g(t)], 1, 2))))));
hold off;

P = getEqual(f, g, t0, t1, N);

hold on;
plot(P(1, :), P(2, :), "--ro", 'MarkerSize', 8, 'MarkerFaceColor', 'r');
disp("equal line length");
disp(median(abs(diff(vecnorm(diff(P, 1, 2))))));
legend("curve", "equal delta t", "equal line length", 'Location', 'southeast');
axis square;
hold off;
disp("length of curve:")
disp(sum(vecnorm(diff([f(tt); g(tt)], 1, 2))))


function P = getEqual(f, g, t0, t1, N)
    t = linspace(t0, t1, N);
    nIt = 1000;
    for i = 1:nIt
        p = [f(t); g(t)];
        d = vecnorm(diff(p, 1, 2));
        r = (1/2) .* diff(d) ./ (d(1:size(d, 2)-1) + d(2:size(d, 2)));
        t(2:size(t, 2)-1) = t(2:size(t, 2)-1) + r .* (diff(t(2:size(t, 2))) .* (r >= 0) + diff(t(1:size(t, 2)-1)) .* (r < 0));
    end
    P = [f(t); g(t)];
end