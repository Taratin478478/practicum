import numpy as np
import matplotlib.pyplot as plt

# Определяем функцию
def f(x):
    return np.maximum(x + 1, -x)

# Создаём массив точек x от -1 до 1
x = np.linspace(-1, 1, 500)

# Вычисляем значения функции
y = f(x)

# Строим график
plt.figure(figsize=(8, 5))
plt.plot(x, y, linewidth=2, color='blue', label=r'$f(x) = \max(x + 1, -x)$')

# Настройка внешнего вида
plt.axhline(0, color='black', linewidth=0.5, linestyle='--')
plt.axvline(0, color='black', linewidth=0.5, linestyle='--')
plt.grid(True, linestyle=':', alpha=0.7)

# Подписи
plt.xlabel(r'$x_2$')
plt.ylabel(r'$f_1(x_1, x_2)$')

plt.tight_layout()
plt.show()