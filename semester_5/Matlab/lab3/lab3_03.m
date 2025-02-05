%% 3

A = [1, 2, 3; 4, 5, 6; 7, 8, 9];
disp("A: ");
disp(A);

disp("expm(A): ");
disp(expm(A));


N = 100;
B = eye(3);
E = eye(3);
for i = 1:N
    B = B * A ./ i;
    E = E + B;
end
fprintf("Сумма первых %d слагаемых ряда:\n", N);
disp(E);

RelTol = 1e-5;
AbsTol = 1e-7;
opts = odeset('RelTol', RelTol, 'AbsTol', AbsTol);
[t, x] = ode45(@(t, x) blkdiag(A, A, A) * x, [0, 0.5, 1], reshape(eye(3), [9, 1]), opts);
fprintf("решение ОДУ методом ode45 c RelTol = %e, AbsTol = %e:\n", RelTol, AbsTol);
disp(reshape(x(3, :), [3, 3]));


