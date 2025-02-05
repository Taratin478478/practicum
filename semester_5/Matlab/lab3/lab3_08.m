clc; clear; close all;

x = linspace(-1, 1, 1000);
trueSol = @(x) (3 * exp(1) / (exp(2) - 1)) .* (exp(x) - exp(-x)) - 2 .* x;
plot(x, trueSol(x));
sol = bvp4c(@ode, @bc, bvpinit(x, @(x) [0, 0]));
hold on;
plot(sol.x,sol.y(1, :));
hold off;
fprintf("L2 diff norm: %.10f\n", sqrt(trapz(x, (trueSol(x) - sol.y(1, :)) .^ 2)));
fprintf("C diff norm:  %.10f\n", max(abs(trueSol(x) - sol.y(1, :))));
legend('true solution','bvp4c solution','Location','southeast');

function dy = ode(x, y)
    dy(1) = y(2);
    dy(2) = y(1) + 2*x;
end

function res = bc(ya,yb)
    res(1) = ya(1)+1;
    res(2) = yb(1)-1;
end
