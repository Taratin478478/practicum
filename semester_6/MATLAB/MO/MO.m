%% Метод проекции градиента
clc;

a = [1; 1; 1; 1; 1; 0; 0; 0; 0; 0];
b = [0; 0; 0; 0; 0; 2; 3; 2; 1; 0];
c = [1; 2; 3; 4; 5; 4; 3; 2; 1; -1];
d = [0; 1; 0; 0; 0; 0; 0; 0; 0; 0];
r = 2;

u0 = [1; 2; 3; 4; 5; 6; 7; 8; 9; 0];
%u0 = d;
alpha = 1/5;
n_iter = 10;
u = u0;
fprintf("step 0: J(u) = %f\n", J(u, a, b, c));
disp(u');
for i = 1:n_iter
    u = projection(u - alpha * dJ(u, a, b, c), d, r);
    fprintf("step %d: J(u) = %f\n", i, J(u, a, b, c));
    disp(u');
end

%% Метод Ньютона
clc;

u0 = [1; 4; 3; 4; 5; 6; 7; 8; 9; 0];
n_iter = 10;
n_subiter = 10;
alpha = 1/5;
u = u0;
fprintf("step 0: J(u0) = %f\n", J(u, a, b, c));
disp(u');
for i = 1:n_iter
    uk = u;
    dJku = @(uk, a, b, c) dJk(u, uk, a, b, c);
    for j = 1:n_subiter
        uk = projection(uk - alpha * dJku(uk, a, b, c), d, r);
    end
    u = uk;
    fprintf("step %d: J(u) = %f\n", i, J(u, a, b, c));
    disp(u');
end

%% Симплекс метод
clc;
% J(u) = <c, u> -> inf, u \in U = {u: u >= 0, Au = b}

c = [1; 1; -1; 0; 1];
A = [1  0  0  1 -1;
     1  1  0  2  0;
     0  0  1  1  0];

b = [1; 3; 1];

S = [A b; c' 0];
basis = [1, 2, 3];
min_val = -1;
count = 1;
eps = 1e-6;
disp(S);

while min_val < -eps
    fprintf("Шаг %d\n", count);
    disp("Базисные столбцы:");
    disp(basis);
    B = S(1:end-1,basis);
    R = [inv(B) zeros(3, 1); zeros(1, 3) 1];
    S = R*S;
    disp(S);
    R = [eye(3) zeros(3, 1); -S(end, basis) 1];
    S = R*S;
    disp(S);
    u = zeros(5, 1);
    u(basis) = S(1:end-1, end);
    disp("Угловая точка u:")
    disp(u');
    fprintf("J(u) = %f\n\n", -S(end, end));
    [min_val, min_id] = min(S(end, 1:end-1));
    decider = S(1:end-1, end) ./ S(1:end-1, min_id);
    [~, old_id] = min(decider);
    basis(old_id) = min_id;
    count = count + 1;
end

disp("u* = ");
disp(u');
fprintf("J* = J(u*) = %f\n\n", -S(end, end));

%%

function y = J(u, a, b, c)
   y = norm(u - a)^2 + norm(u - b)^4 + dot(u, c);
end

function y = dJ(u, a, b, c)
   y = 2*(u - a) + 4 * norm(u - b)^2 * (u - b) + c; 
end

% U = {u: ||u|| <= r, <d, u> >= 1}
function p = projection(u, d, r)
    if (norm(u) <= r) && (dot(d, u) >= 1)
        p = u;
    elseif (dot(d, u) >= 1)
        p = r * u / norm(u);
    else
        p = u - dot(u, d) * d / dot(d, d);
        r0 = sqrt(r^2 - norm(d)^2);
        if norm(p) > r0
            p = p / norm(p) * r0;
        end
        p = p + d / dot(d, d);

    end
end

function y = ddJ(u, h, a, b, c)
    y = 2*h + 4 * norm(u - b)^2 * h + 4 * dot(u -b, h)*(u - b); 
end

function y = Jk(u, uk, a, b, c)
    y = dot(dJ(uk, a, b, c), u - uk) + (1/2)*dot(ddJ(uk, u - uk, a, b, c), u - uk);
end

function y = dJk(u, uk, a, b, c)
    y = dJ(uk, a, b, c) + ddJ(uk, u - uk, a, b, c);
end





