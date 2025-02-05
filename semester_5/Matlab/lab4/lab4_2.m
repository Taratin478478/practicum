%% 2

clc; clear; close all;

A = [1, 3, 3, 7; 2, 0, 2, 5; 3, 1, 4, 1];

disp('Matlab:');
[Q, R] = qr_matlab(A);
disp('Q = ');
disp(Q);
disp('R = ');
disp(R);

disp('C:')
[Q, R] = qr_c(A);
disp('Q = ');
disp(Q);
disp('R = ');
disp(R);

%% 3

N = 20;
M = 100;
err_qr = zeros(N, 1);
err_qr_matlab = zeros(N, 1);
err_qr_c = zeros(N, 1);
err_arr = zeros(M,1);
err_arr_matlab = zeros(M,1);
err_arr_c = zeros(M,1);
t1 = zeros(M,1);
t2 = zeros(M,1);
t3 = zeros(M,1);
times_qr = zeros(N, 1);
times_qr_matlab = zeros(N, 1);
times_qr_c = zeros(N, 1);
for i = 1:N
    for j=1:100
        A = randi(100, i);
        tic;
        [Q, R] = qr(A);
        t1(j) = toc;
        err_arr(j) = norm(A - Q*R, "fro");
        tic;
        [Q, R] = qr_matlab(A);
        t2(j) = toc;
        err_arr_matlab(j)= norm(A - Q*R, "fro");
        tic;
        [Q, R] = qr_c(A);
        t3(j) = toc; 
        err_arr_c(j) = norm(A - Q*R, "fro");
    end
    err_qr(i) = mean(err_arr);
    err_qr_matlab(i) = mean(err_arr_matlab);
    err_qr_c(i) = mean(err_arr_c);
    times_qr(i) = mean(t1);
    times_qr_matlab(i) = mean(t2);
    times_qr_c(i) = mean(t3);

end

plot(1:N, err_qr, 1:N, err_qr_matlab, 1:N, err_qr_c);
hold on;
grid on;
xlabel('Размер матрицы');
ylabel('Невязка');
legend('qr', "qr matlab", 'qr c');
title('Сравнение невязки')
hold off;
figure;
plot(1:N, times_qr);
hold on;
plot(1:N, times_qr_matlab);
plot(1:N, times_qr_c)
grid on;
xlabel('Размер матрицы');
ylabel('Время вычисления');
legend('qr', 'qr matlab', 'qr С');
title('Сравнение времени выполнения')
hold off;

%%

function [Q, R] = qr_matlab(A)
    [m, n] = size(A);
    R = A;
    Q = eye(m);
    for i = 1:n-1
        u = R(i:end,i);
        u(1) = u(1) - vecnorm(u);
        u = u ./ vecnorm(u);
        Qn = eye(m - i + 1) - 2 * (u * u');
        Qn = blkdiag(eye(i - 1), Qn);
        R = Qn * R;
        Q = Q * Qn';
    end
end
