import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

# Определение функции
def f1(x_1, x_2):
    return max([x_2 - x_1, 2*x_2 - 2*x_1 + 1, 3*x_2 - 3*x_1 ])

# Создание сетки значений
x1 = np.linspace(-2, 3, 150)
x2 = np.linspace(-2, 3, 150)
X1, X2 = np.meshgrid(x1, x2)

# Вычисление значений функции для каждой точки сетки
Z = np.vectorize(f1)(X1, X2)

# Создание фигуры с 3D графиком
fig = plt.figure(figsize=(12, 9))
ax = fig.add_subplot(111, projection='3d')

# Построение поверхности
surf = ax.plot_surface(X1, X2, Z, cmap='coolwarm')

# Добавление прямоугольника при z=0
# Углы прямоугольника: x1 от -1 до 1, x2 от -2 до 2, z=0
vertices = [
    [-1, -1, 0],
    [1, -1, 0],
    [1, 1, 0],
    [-1, 1, 0]
]

# Создаём полигон
rectangle = Poly3DCollection([vertices], alpha=0.3, facecolor='cyan', edgecolor='blue', linewidth=2)
ax.add_collection3d(rectangle)

# Добавляем контур прямоугольника (линии)
x_rect = [-1, 1, 1, -1, -1]
y_rect = [-1, -1, 1, 1, -1]
z_rect = [0, 0, 0, 0, 0]
ax.plot(x_rect, y_rect, z_rect, 'b-', linewidth=2.5, label='Область определения')


# Подписи осей с LaTeX
ax.set_xlabel(r'$x_1$', fontsize=14, labelpad=10)
ax.set_ylabel(r'$x_2$', fontsize=14, labelpad=10)
ax.set_zlabel(r'$f_1(x_1, x_2)$', fontsize=14, labelpad=10)


# Настройка углов обзора
ax.view_init(elev=25, azim=45)

# Сетка
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()
