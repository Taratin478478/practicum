%% 1
f = @(x) x.^2 - x + 2;
compareInterp(linspace(-2, 2, 10), linspace(-2, 2, 500), f);
f = @(x) sin(exp(x));
compareInterp(linspace(-2, 4, 20), linspace(-2, 4, 500), f);
f = @sign;
compareInterp(linspace(-2, 2, 20), linspace(-2, 2, 500), f);    
f = @(x) exp(sin(10.*x) .* exp(-x.^2 + x)) + sin(1./(x - 3));
compareInterp(linspace(-2, 4, 20), linspace(-2, 4, 500), f);
%% 2
f = @sin;
M2 = 1;
xx = linspace(-pi, pi, 500);
m = 10;
H = 2:m;
aprior_error = zeros(m - 1, 1);
real_error = zeros(m - 1, 1);
for n = H
    x = linspace(-pi, pi, n);
    aprior_error(n - 1) = M2 * (2 * pi / (n - 1)) ^ 2 / 8;
    real_error(n - 1) = max(abs(f(xx) - interp1(x, f(x), xx, 'linear')));
end
subplot(2, 1, 1);
hold on;
plot(H, aprior_error);
title('small error');
xlabel('n');
ylabel('error');
plot(H, real_error);
legend('aprior error','real error','Location','southeast');
hold off;

f = @(x) sin(1./x);
xx = linspace(pi/6, pi, 500);
M2 = max(abs((2.*cos(1./xx).*xx-sin(1./xx))./(xx.^4)));
m = 10;
H = 2:m;
aprior_error = zeros(m - 1, 1);
real_error = zeros(m - 1, 1);
for n = H
    x = linspace(-pi, pi, n);
    aprior_error(n - 1) = M2 * (5 * pi / 6 / (n - 1)) ^ 2 / 8;
    real_error(n - 1) = max(abs(f(xx) - interp1(x, f(x), xx, 'linear')));
end
subplot(2, 1, 2);
hold on;
plot(H, aprior_error);
title('big error');
xlabel('n');
ylabel('error');
plot(H, real_error);
legend('aprior error','real error','Location','southeast');
hold off;

function compareInterp(x, xx, f)
    figure('name','Interpolation');
    
    subplot(2, 2, 1);
    plot(xx, f(xx));
    hold on;
    title('nearest method');
    xlabel('x');
    ylabel('f(x)');
    plot(xx, interp1(x, f(x), xx, 'nearest'));
    legend('true func','nearest interp','Location','southeast');
    hold off;
    
    subplot(2, 2, 2);
    plot(xx, f(xx));
    hold on;
    title('linear method');
    xlabel('x');
    ylabel('f(x)');
    plot(xx, interp1(x, f(x), xx, 'linear'));
    legend('true func','linear interp','Location','southeast');
    hold off;
    
    subplot(2, 2, 3);
    title('interpolation');
    plot(xx, f(xx));
    hold on;
    title('spline method');
    xlabel('x');
    ylabel('f(x)');
    plot(xx, interp1(x, f(x), xx, 'spline'));
    legend('true func','spline interp','Location','southeast');
    hold off;
    
    subplot(2, 2, 4);
    title('interpolation');
    plot(xx, f(xx));
    hold on;
    title('pchip method');
    xlabel('x');
    ylabel('f(x)');
    plot(xx, interp1(x, f(x), xx, 'pchip'));
    legend('true func','pchip interp','Location','southeast');
    hold off;
end
