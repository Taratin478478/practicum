%% 4
fn = @(n, x) x.^n;
f = @(x) x == 1;
convergenceFunc(fn, f, 0, 1, 10, "pointwise");
fn = @sin_partial;
f = @sin;    
convergenceFunc(fn, f, 0, 2 * pi, 10, "uniform");
fn = @(n, x) x.^n;
f = @(x) 0;
convergenceFunc(fn, f, 0, 1, 10, "L2");


function convergenceFunc(fn,f,a,b, n, convType)
    figure;
    mov(1:n) = struct('cdata', [],'colormap', []);
    x = linspace(a,b,1000);
    maxy = max(f(x));
    miny = min(f(x));
    for i = 1:n
        maxy = max(maxy, max(fn(i, x)));
        miny = min(miny, min(fn(i, x)));
    end
    if (min(f(x)) < max(f(x)))
        maxy = min(maxy, max(f(x)) + (1/2) * (max(f(x)) - min(f(x))));
        miny = max(miny, min(f(x)) - (1/2) * (max(f(x)) - min(f(x))));
    end
    ax = [a; b; miny; maxy];
    for i = 0:(n - 1)
        plot(x, fn(i, x));
        hold on;
        plot(x, f(x));
        if convType == "uniform"
            title("sup|f_n(x) - f(x)| = " + max(abs(fn(i, x) - f(x))));
        elseif convType == "L2"
            title("||f_n(x) - f(x)|| = " + sqrt(integral(@(x) (fn(i, x) - f(x)).^2, a, b)));
        end
        axis(ax);
        hold off;
        mov(i+1) = getframe();
    end
    movie(mov, 1000, 3);
end

function y = sin_partial(n, x)
    y = zeros(size(x));
    for k = 1:n
        y = y + (-1)^(k+1) .* x.^(2*k-1) ./ factorial(2*k-1);
    end
end