% Исходные параметры
a = -10;               % Начало интервала (расширен)
b = 10;                % Конец интервала (расширен)
N = 2048;              % Увеличено количество точек
x = linspace(a, b, N); % Узлы дискретизации
dx = (b - a) / N;      % Шаг по x

% Определение функции
f = exp(-x.^2);        % Гауссиана

% Применение FFT
F_fft = fft(f) * dx;   % FFT с нормировкой по x
F_fft = fftshift(F_fft); % Центровка спектра

% Частоты
freq = (-N/2:N/2-1) / (N * dx);

% Аналитическое решение
F_analytic = sqrt(pi) * exp(-pi^2 * freq.^2); % Амплитуда
real_analytic = F_analytic;                   % Вещественная часть
imag_analytic = zeros(size(freq));            % Мнимая часть

% Разделение FFT на части
real_part = real(F_fft); % Вещественная часть
imag_part = imag(F_fft); % Мнимая часть

% Визуализация
figure;

% Исходная функция
subplot(4, 1, 1);
plot(x, f, 'b', 'LineWidth', 1.5);
title('Исходная функция');
xlabel('x');
ylabel('f(x)');

% Вещественная часть спектра
subplot(4, 1, 2);
plot(freq, real_part, 'r', 'LineWidth', 1.5);
hold on;
plot(freq, real_analytic, 'k--', 'LineWidth', 1.2);
title('Вещественная часть спектра');
xlabel('Частота k');
ylabel('Re(F(k))');
legend('Численное решение', 'Аналитическое решение');

% Мнимая часть спектра
subplot(4, 1, 3);
plot(freq, imag_part, 'g', 'LineWidth', 1.5);
hold on;
plot(freq, imag_analytic, 'k--', 'LineWidth', 1.2);
title('Мнимая часть спектра');
xlabel('Частота k');
ylabel('Im(F(k))');
legend('Численное решение', 'Аналитическое решение');

% Амплитудный спектр
subplot(4, 1, 4);
plot(freq, abs(F_fft), 'b', 'LineWidth', 1.5);
hold on;
plot(freq, F_analytic, 'k--', 'LineWidth', 1.2);
title('Амплитудный спектр');
xlabel('Частота k');
ylabel('|F(k)|');
legend('Численное решение', 'Аналитическое решение');
