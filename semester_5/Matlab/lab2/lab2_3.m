%% 3
disp("delta = step, func = cos")
deltaFunc(@step, @cos, 10, -4, 4);
sincn = @(n, x) sin(pi .* n .* x) ./ (pi .* x);
disp("delta = sinc, func = exp")
deltaFunc(sincn, @exp, 10, -4, 4);
gaussn = @(n, x) n ./ sqrt(pi) .* exp(-((n .* x) .^ 2));
disp("delta = gauss, func = x.^4 - 4.*x.^2 + 5")
deltaFunc(gaussn, @(x) x.^4 - 4.*x.^2 + 5, 10, -4, 4);

function deltaFunc(fn,phi,N,a,b)
    figure;
    x = linspace(a, b, 1000);
    error = zeros(N, 1);
    hold on;
    for n = 1:N
        plot(x, fn(n, x));
        error(n) = abs(integral(@(x) fn(n, x) .* phi(x), a, b) - phi(0));
    end
    disp(error);
    hold off;
end

function y = step(n, x) % [-4, 4]
    d = 4 * 2 ^ (-n+1);
    y = ones(size(x)) ./ (2 * d) .* (abs(x) < d);
end