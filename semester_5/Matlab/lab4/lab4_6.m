%% 1
clc; clear; close all;

M = 40;
N = 45;
mu = 120;
fHandle = @(x, y) (x.^2 + y.^2).^2;
xiHandle = @(x) sin(2*pi*x);
etaHandle = @(y) sin(-2*pi*y);
[x, y] = meshgrid(0:1/M:1, 0:1/N:1);
u = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N);
figure;
surf(x', y', real(u));
xlabel('x');
ylabel('y');
title('Пример 1');
%% 2
clc; clear; close all;

M = 50;
N = 50;
mu = 10;
fHandle = @(x, y) 10*sin(x.*y);
xiHandle = @(x) zeros(size(x));
etaHandle = @(y) zeros(size(y));
[x, y] = meshgrid(0:1/M:1, 0:1/N:1);
u = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N);
figure;
surf(x', y', real(u));
xlabel('x');
ylabel('y');
title('Пример 2');
%% 3
clc; clear; close all;

M = 20;
N = 50;
mu = 10;
fHandle = @(x, y) zeros(size(x));
xiHandle = @(x) zeros(size(x));
etaHandle = @(y) zeros(size(y));
[x, y] = meshgrid(0:1/M:1, 0:1/N:1);
u = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N);
figure;
surf(x', y', real(u));
xlabel('x');
ylabel('y');
title('Пример 3');
%%
M = 50;
N = 50;
mu = 100;
u1zero = 1;
u2zero = 1;
[x, y] = meshgrid(0:1/M:1, 0:1/N:1);
val_A = uAnalytical(x, y, u1zero, u2zero, mu);
val_N = uNumerical(u1zero, u2zero, mu, M, N);
figure;
subplot(1, 2, 1);
surf(x, y, val_A);
hold on;
title('Аналитическое');
subplot(1, 2, 2);
surf(x', y', real(val_N));
title('Численное');
hold off;
figure;
surf(x, y, abs(val_A - real(val_N)'));
title('Невязка');
xlabel('X');
ylabel('Y');
zlabel('Z');


function u = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N)
    hx = 1/M;
    hy = 1/N;
    x = 0:hx:1-hx;
    y = 0:hy:1-hy;
    [X, Y] = meshgrid(x, y);
    p = 0:M-1;
    q = 0:N-1;
    [P, Q] = meshgrid(p, q);
    
    xi = xiHandle(x); 
    eta = etaHandle(y);
    f = transpose(fHandle(X, Y));
    gamma = ifft(xi);
    delta = ifft(eta);
    f(:, 1) = 0;
    f(1, :) = 0;
    
    cHandle = @(p, q) M^2*(exp(-2 * pi * 1i * p / M) - 2 + exp(2 * pi * 1i * p / M)) + N^2*(exp(-2 * pi * 1i * q / N) - 2 + exp(2 * pi * 1i * q / N)) - mu;
    c = 1./transpose(cHandle(P, Q));
    
    btilde = ifft2(f);
    
    pexpHandle = @(k, p) exp(2*pi*1i*k.*p./M)./ (M*N);
    qexpHandle = @(l, q) exp(2*pi*1i*l.*q./N)./(M*N);
    [P1, P2] = meshgrid(1:1:M-1, 0:1:M-1);
    ep = transpose(pexpHandle(P1, P2));
    [Q1, Q2] = meshgrid(1:1:N-1, 0:1:N-1);
    eq = transpose(qexpHandle(Q1, Q2));
    

    A = sum(c, 2)./(M*N); 
    B = transpose(ep).*repmat(sum(c, 2), 1, M-1); 
    C = transpose(eq * transpose(c));
    D1 = transpose(gamma) - sum(btilde .* c, 2);

    E1 = [A, B, C];

    A = transpose(sum(c, 1))./(M * N);
    B = transpose(ep * c); 
    C = transpose(eq .* repmat(sum(c, 1), N-1, 1)); 
    D2 = transpose(delta - sum(btilde .* c, 1));

    E2 = [A, B, C];

    E = [E1; E2];
    G = [D1; D2];

    E = E(2:end, :); 
    G = G(2:end, :);

    f0 = transpose(E\G);

    f(:, 1) = f0(1:M);
    f(1, 2:end) = f0(M+1:end);
    b = ifft2(f);
    a = c .* b;
    u = fft2(a);

    u = [u, transpose(xi); eta, xiHandle(1)];
end

function u = uAnalytical(xMat,yMat,u1Zero,u2Zero,mu)
    C1 = 4/((3 - mu)^2 - 16);
    A1 = (3 - mu)/((3 - mu)^2 - 16);
    D1 = (3 - mu)/((3 - mu)^2 + 16) * (4 * C1 + 2 * A1 - 4 * (4 * A1 - 2 * C1) / (3 - mu));
    B1 = (4 * A1 - 2 * C1 + 4 * D1) / (3 - mu);
    uch1 = @(x) (A1 .* x + B1) .* exp(-2 .* x) .* cos(x) + (C1 .* x + D1) .* exp(-2 .* x) .* sin(x);
    C12 = (u1Zero .* (1 - exp(-sqrt(mu))) - uch1(1) + uch1(0) .* exp(-sqrt(mu))) ./ (exp(sqrt(mu)) - exp(-sqrt(mu)));
    C11 = u1Zero - uch1(0) - C12;
    uoo1 = C11 .* exp(-sqrt(mu) .* xMat) + C12 .* exp(sqrt(mu) .* xMat);
    
    A2 = -1 / (4 + mu);
    C2 = 0;
    B2 = -2 / (4 + mu);
    D2 = 4 / (4 + mu)^2;
    uch2 = @(x) (A2 * x + B2) .* exp(-2 * x) .* cos(x) + (C2 * x + D2) .* exp(-2 * x) .* sin(x);
    C22 = (u2Zero * (1 - exp(-sqrt(mu))) + uch2(0)  * exp(-sqrt(mu)) - uch2(1)) ./ (exp(sqrt(mu)) - exp(-sqrt(mu)));
    C21 = u2Zero - uch2(0) - C22;
    uoo2 = C21 * exp(-sqrt(mu) * yMat) + C22 * exp(sqrt(mu) * yMat);
    
    u1 = uch1(xMat) + uoo1;
    u2 = uch2(yMat) + uoo2;
    u = u1 + u2;
end

function vals = uNumerical(u1zero, u2zero, mu, M, N)
    fHandle = @fGiven;
    xiHandle = @(x) uAnalytical(x, zeros(size(x)), u1zero, u2zero, mu);
    etaHandle = @(y) uAnalytical(zeros(size(y)), y, u1zero, u2zero, mu);
    vals = solveDirichlet(fHandle, xiHandle, etaHandle, mu, M, N);
end

function u = fGiven(x, y)
    u = x .* exp(-2 .* x) .* cos(x) + (2 + y) .* cos(2 * y);
end