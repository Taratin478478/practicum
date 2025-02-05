%% 1
a = 0;
b = 2;  
n = 100;
x = a:((b-a)/(n-1)):b;
f = acos(sin(x.^3 - 5*abs(x)));
plot(x, f);
[maxval, maxn] = max(f);
[minval, minn] = min(f);
maxx = maxn * (b - a) / n;
minx = minn * (b - a) / n;
hold on
plot(maxx, maxval, 'r*', minx, minval, 'r*');
hold off
maxval
minval
%% 2
n = input('enter prime number n\n');
if ~isprime(n)
        disp('number is not prime :(\n');
        return;
end
v = 7:14:n;
A = (1:n).' * ones(1, n) + 1
B = 1:(n+1)^2;
B1 = B(:);
B1 = B1(2:2:end)
B1 = [zeros(size(B1)).'; B1.']
if mod(n, 2) == 0
    B1 = [reshape(B1, [], 1); 0];
end
B1 = reshape(B1, [], n+1).'
B = reshape(B, [], n+1).' - 2.*B1
c = B(:);
D = B(:,end-1:end);
%% 3
A = randi([-2, 12], 5, 8)   
max_diag = max(diag(A))
max_ratio = max(prod(A, 2)./sum(A, 2))
A = sortrows(A)
%% 4
n = 3;
m = 4;
A = randi([0, 9], n, m)
if mod(m, 2) == 1
    disp('cant build matrix G\n');
    return;
end
R = A(1:2:end, 2:2:end);
B = A(2:2:end, 1:2:end);
G = A;
G(1:2:end, 2:2:end) = 0
G(2:2:end, 1:2:end) = 0
G = G(:, 1:2:end) + G(:, 2:2:end)
%% 5
n = 3;
m = 4;
a = randi([0, 9], n, 1)
b = randi([0, 9], m, 1)
r = [repelem(a, m), repmat(b, n, 1)]
%meshgrid 
%% 6
n = 3;
A = randi([0, 9], 3, n)
repelem(A, 1, n)
repmat(A, 1, n)
R = reshape(sqrt(sum(cross(repelem(A, 1, n), repmat(A, 1, n)).^2)), n, n)
%% 7
n = 3;
m = 2;
a = randi([-9, 9], n, 1)
b = randi([-9, 9], m, 1)
a1 = a(1:min(n, m));
b1 = b(1:min(n, m));
c = max(max(a1 - b1, 0) - min(a1 - b1, 0))
%% 8
n = 3;
k = 2;
A = randi([0, 9], k, n)
R = reshape(sqrt(sum((repelem(A, 1, n) - repmat(A, 1, n)).^2)), n, n)
%% 9 
num_tries = 100;
num_dims = 200;

my_res = zeros(num_dims, 1);
res = zeros(num_dims, 1);
for n = 1:num_dims
    R = zeros(n, n);
    my_cur = zeros(num_tries, 1);
    cur = zeros(num_tries, 1);
    tic;
    for i = 1:num_tries
        A = randi([0, 9], n, n);
        B = randi([0, 9], n, n);
        tic;
        R = my_add(A, B);
        my_cur(i) = toc;
        tic;
        R = A + B;
        cur(i) = toc;
    end
    my_res(n) = median(my_cur);
    res(n) = median(cur);
end
my_res
res
plot(1:num_dims, res);
hold on;
plot(1:num_dims, my_res);
hold off;
%% 10
n = 3
%a = randi([-9, 9], n, 1);
a = [3, 4, 5, 4, 3]
if all(a == flip(a))
    disp('vector is symmetrical :)\n');
else
    disp('vector is not symmetrical :(\n');
end
% all
%% 11
n = 1000;
a = 100;
b = 90;
v = rand(1, n) * a;
disp(['ratio of elements greater than ', num2str(b), ' to number of elements: ', num2str(sum(v > b) / n)]);
disp(['a/2b: ', num2str(a/(2*b))]);
%% 12 
%rectangles([1, 2, 3], 1:0.5:2)
simpson([0, 0.5, 1, 1.5, 2; 1, 2, 3, 4, 5], [0, 2, 3])

h = 0.01;        
a = 3;

subplot(3, 3, 1);
H = 0:h:a;
X = tril(repmat(H, size(H, 2), 1));
Y = tril(exp(-X.^2));
plot(H, trapz(H, Y.'));
title('trapz');
xlabel('x');
ylabel('F(x)');

subplot(3, 3, 2);
H = 0:h:a;
X = tril(repmat(H, size(H, 2), 1)) + triu(repmat(H.', 1, size(H, 2)), 1);
Y = exp(-X.^2);
plot(H, rectangles(Y, X));
title('rectangles');
xlabel('x');
ylabel('F(x)');

subplot(3, 3, 3);
H = 0:h/2:a;    
X = tril(repmat(H, size(H, 2), 1)) + triu(repmat(H.', 1, size(H, 2)), 1);
X = X(1:2:end, :);
Y = exp(-X.^2);
plot(H(1:2:end), simpson(Y, X));
title('simpson');
xlabel('x');
ylabel('F(x)');

D = logspace(0, -5, 100);
trapz_err = zeros(size(D, 2));
rectangles_err = zeros(size(D, 2));
simpson_err = zeros(size(D, 2));
trapz_time = zeros(size(D, 2));
rectangles_time = zeros(size(D, 2));
simpson_time = zeros(size(D, 2));

m = 100;
i = 1;
for h = D
    H = 0:h:a;
    Y = exp(-H.^2);
    for j = 1:m
        tic;
        val1 = trapz(H, Y);
        trapz_time(i) = trapz_time(i) + toc;
    end
    H = 0:h/2:a;
    Y = exp(-H.^2);
    val2 = trapz(H, Y);
    trapz_err(i) = abs(val2 - val1);
    
    H = 0:h:a;
    Y = exp(-H.^2);
    for j = 1:m
        tic;
        val1 = rectangles(Y, H);
        rectangles_time(i) = rectangles_time(i) + toc;
    end
    H = 0:h/2:a;
    Y = exp(-H.^2);
    val2 = rectangles(Y, H);
    rectangles_err(i) = abs(val2 - val1);

    H = 0:h/2:a;    
    Y = exp(-H.^2);
    for j = 1:m
        tic;
        val1 = simpson(Y, H);
        simpson_time(i) = simpson_time(i) + toc;
    end
    H = 0:h/4:a;    
    Y = exp(-H.^2);
    val2 = simpson(Y, H);
    simpson_err(i) = abs(val2 - val1);
    
    i = i + 1;
end

trapz_time = trapz_time / 100;
rectangles_time = rectangles_time / 100;
simpson_time = simpson_time / 100;

subplot(3, 3, 4);
loglog(D, trapz_err);
title('trapz error');
xlabel('h');
ylabel('error');

subplot(3, 3, 5);
loglog(D, rectangles_err);
title('rectangles error');
xlabel('h');
ylabel('error');

subplot(3, 3, 6);
loglog(D, simpson_err);
title('simpson error');
xlabel('h');
ylabel('error');

subplot(3, 3, 7);
loglog(D, trapz_time);
title('trapz time');
xlabel('h');
ylabel('t');

subplot(3, 3, 8);
loglog(D, rectangles_time);
title('rectangles time');
xlabel('h');
ylabel('t');

subplot(3, 3, 9);
loglog(D, simpson_time);
title('simpson time');
xlabel('h');
ylabel('t');
%% 13
f = @(x) exp(x.*sin(x));
df = @(x) exp(x.*sin(x)).*sin(x)+x.*exp(x.*sin(x)).*cos(x);

    
x = 1;
n = 1000;
H = logspace(-10, 1, n);

true = df(x);
middle = (f(x + H) - f(x - H)) ./ (2.*H);
left = (f(x + H) - f(x)) ./ H;

loglog(H, abs(true - left));
hold on;
loglog(H, abs(true - middle));
xlabel('step h');
ylabel('delta derivative');
legend('left','middle','Location','southeast');
hold off;


%%

function R = my_add(A, B)
    if (size(A) ~= size(B))
        disp('matrixes have different sizes\n');
        return
    end
    R = zeros(size(A));
    for i = 1:size(A, 1)
        for j = 1:size(A, 2)
            R(i, j) = A(i, j) + B(i, j);
        end
    end
end


function I = rectangles(Y, X)
    if ~exist('X', 'var')
        I = sum(Y(:, 1:end-1), 2);
    else
        I = sum(Y(:, 1:end-1) .* diff(X, 1, 2), 2);
        %disp(I(size(I, 1)))
    end
end

function I = simpson(Y, X) % size(Y) == 2n + 1 || [m, 2n + 1], size(X) == 2n + 1
    if ~exist('X', 'var')
        I = sum(Y(:, 1:2:end-2) + 4 * Y(:, 2:2:end-1) + Y(:, 3:2:end), 2) ./ 6;
    else
        I = sum((Y(:, 1:2:end-2) + 4 * Y(:, 2:2:end-1) + Y(:, 3:2:end)) .* diff(X(:,1:2:end), 1, 2), 2) ./ 6;
        %disp(I(size(I, 1)))
    end
end