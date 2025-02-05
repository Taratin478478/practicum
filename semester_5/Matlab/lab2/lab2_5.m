%% 5
fourierApprox(@(x) x.^2, -3, 5, 20, "standart")
fourierApprox(@(x) sin(10.*x), -1, 1, 20, "chebyshev")
fourierApprox(@(x) exp(-x.^2), -1, 1, 20, "jacobi")


function fourierApprox(f, a, b, n, meth)
    if meth == "standart"
        getFunc = @getStandTrig;
        lb = -pi;
        rb = pi;
        scalarProd = @(g, fk) integral(@(x) g(x) .* fk(x), lb, rb);
    elseif meth == "chebyshev"
        getFunc = @getChebyshev;
        lb = -1;
        rb = 1;
        scalarProd = @(g, fk) integral(@(x) g(x) .* fk(x) ./ sqrt(1 - x.^2), lb, rb);
    elseif meth == "jacobi"
        alpha = 1/2;
        beta = 3/2;
        getFunc = @(n) getJacobi(n, alpha, beta);
        lb = -1;
        rb = 1;
        scalarProd = @(g, fk) integral(@(x) g(x) .* fk(x) .* (1-x).^alpha .* (1+x).^beta, lb, rb);
    end
    mov(1:n+1) = struct('cdata', [],'colormap', []);
    x = linspace(a,b,1000);
    xx = linspace(lb,rb,1000);
    maxy = max(f(x));
    miny = min(f(x));
    for k = 1:n
        fn = getFunc(k);
        maxy = max(maxy, max(fn(x)));
        miny = min(miny, min(fn(x)));
    end
    if (min(f(x)) < max(f(x)))
        maxy = min(maxy, max(f(x)) + (1/2) * (max(f(x)) - min(f(x))));
        miny = max(miny, min(f(x)) - (1/2) * (max(f(x)) - min(f(x))));
    end
    ax = [a; b; miny; maxy];
    g = @(x) f((x - lb) ./ (rb - lb) * (b - a) + a);
    sum = zeros(size(f));
    figure;
    for k = 0:n
        fk = getFunc(k);
        
        sum = sum + scalarProd(g, fk) .* fk(xx);
        plot(x, f(x));
        hold on;
        plot(x, sum);
        %plot(x, fk(x));
        %plot(x, g(x) .* fk(x));
        axis(ax);
        hold off;
        mov(k+1) = getframe();
    end
    movie(mov, 1000);
end

function f = getStandTrig(n)
    if n == 0
        f = @(x) 1 / sqrt(2 * pi);
    elseif mod(n, 2) == 0
        f = @(x) cos(n./2.*x) ./ sqrt(pi);
    else
        f = @(x) sin((n + 1)./2.*x) ./ sqrt(pi);
    end
end

function f = getChebyshev(n)
    if n == 0
        f = @(x) 1 / sqrt(pi);
    elseif n == 1
        f = @(x) x .* sqrt(2 / pi);
    elseif n == 2
        f = @(x) (2 .* x.^2 - 1) .* sqrt(2 / pi);
    else
        ch1 = getChebyshev(n-1);
        ch2 = getChebyshev(n-2);
        f = @(x) 2 .* x .* ch1(x) - ch2(x);
    end
end

%{
function f = getChebyshev(n)
    f = @(x) chebyshevT(n, x);
end

%}
function f = getJacobi(n, a, b)
    f = @(x) jacobiP(n, a, b, x);
    f = @(x) f(x) ./ sqrt(integral(@(x) f(x) .* f(x) .* (1-x).^a .* (1+x).^b, -1, 1));
end

