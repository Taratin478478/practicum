import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

# Определение системы дифференциальных уравнений
def system(state, t):
    x, y = state
    
    # dx/dt = -2x/(1+x^2)^2 + 2y
    dxdt = -2*x/(1 + x**2)**2 + 2*y
    
    # dy/dt = -2y/(1+y^2)^2 - 2x/(1+x^2)^2
    dydt = -2*y/(1 + y**2)**2 - 2*x/(1 + x**2)**2
    
    return [dxdt, dydt]

# Создание сетки для векторного поля
x_min, x_max = -3, 3
y_min, y_max = -3, 3
X, Y = np.meshgrid(np.linspace(x_min, x_max, 20),
                   np.linspace(y_min, y_max, 20))

# Вычисление направления векторного поля
U = np.zeros_like(X)
V = np.zeros_like(Y)

for i in range(X.shape[0]):
    for j in range(X.shape[1]):
        dxdt, dydt = system([X[i,j], Y[i,j]], 0)
        U[i,j] = dxdt
        V[i,j] = dydt

# Нормализация векторов для лучшей визуализации
norm = np.sqrt(U**2 + V**2)
norm[norm == 0] = 1  # Избегаем деления на ноль
U_norm = U / norm
V_norm = V / norm

# Создание фигуры
plt.figure(figsize=(12, 10))

# 1. Векторное поле
quiver = plt.quiver(X, Y, U_norm, V_norm, norm, 
                     alpha=0.8, cmap='viridis', 
                     angles='xy', scale_units='xy', scale=25, 
                     width=0.005)

# 2. Фазовые траектории для разных начальных условий
initial_conditions = [
    [-2, -2], [-2, 2], [2, -2], [2, 2],
    [0, 2], [0, -2], [2, 0], [-2, 0],
    [1, 1], [-1, -1], [1, -1], [-1, 1],
    [0.5, 0.5], [-0.5, -0.5], [1.5, 1.5], [-1.5, -1.5],
    [0, 2.5], [0, -2.5], [2.5, 0], [-2.5, 0]
]

# Время интегрирования
t = np.linspace(0, 20, 1000)

# Цветовая карта для траекторий
colors = plt.cm.rainbow(np.linspace(0, 1, len(initial_conditions)))

# Рисуем траектории
for ic, color in zip(initial_conditions, colors):
    solution = odeint(system, ic, t)
    x_traj, y_traj = solution[:, 0], solution[:, 1]
    plt.plot(x_traj, y_traj, color=color, linewidth=1.5, alpha=0.7)
    # Отмечаем начальную точку
    plt.plot(ic[0], ic[1], 'o', color=color, markersize=5, alpha=0.8)

# 3. Отображение стационарных точек
# Точка (0,0) очевидно является стационарной
plt.plot(0, 0, 'r*', markersize=12, 
         markeredgecolor='red', markerfacecolor='red', 
         markeredgewidth=2, label='Стационарная точка (0,0)')

# Настройка графика
plt.xlabel('x', fontsize=14)
plt.ylabel('y', fontsize=14)
plt.title('Фазовый портрет системы\n'
          '$\\dot{x} = -\\frac{2x}{(1+x^2)^2} + 2y,\\ '
          '$\\dot{y} = -\\frac{2y}{(1+y^2)^2} - \\frac{2x}{(1+x^2)^2}$',
          fontsize=12)
plt.grid(True, alpha=0.3, linestyle='--')
plt.axhline(y=0, color='k', linewidth=0.5, alpha=0.5)
plt.axvline(x=0, color='k', linewidth=0.5, alpha=0.5)
plt.xlim(x_min, x_max)
plt.ylim(y_min, y_max)

# Добавление colorbar - ИСПРАВЛЕННАЯ ЧАСТЬ
cbar = plt.colorbar(quiver, label='Скорость движения')

plt.legend()
plt.tight_layout()

# Сохранение графика
plt.savefig('phase_portrait.png', dpi=300, bbox_inches='tight')
plt.show()

# Дополнительный анализ: вычисление якобиана в стационарных точках
def jacobian(x, y):
    # Частные производные для линеаризации
    # df1/dx = производная от -2x/(1+x^2)^2 по x
    df1dx = -2/(1+x**2)**2 + 8*x**2/(1+x**2)**3
    # df1/dy = 2
    df1dy = 2
    
    # df2/dx = производная от -2x/(1+x^2)^2 по x
    df2dx = -2/(1+x**2)**2 + 8*x**2/(1+x**2)**3
    # df2/dy = производная от -2y/(1+y^2)^2 по y
    df2dy = -2/(1+y**2)**2 + 8*y**2/(1+y**2)**3
    
    return np.array([[df1dx, df1dy], [df2dx, df2dy]])

print("\nАнализ в стационарной точке (0,0):")
J = jacobian(0, 0)
print(f"Якобиан:\n{J}")
eigenvals = np.linalg.eigvals(J)
print(f"Собственные значения: {eigenvals}")

# Определение типа особой точки
if np.all(np.real(eigenvals) < 0):
    point_type = "Устойчивый узел"
elif np.all(np.real(eigenvals) > 0):
    point_type = "Неустойчивый узел"
elif np.any(np.real(eigenvals) > 0) and np.any(np.real(eigenvals) < 0):
    point_type = "Седло"
else:
    if np.iscomplexobj(eigenvals):
        if np.real(eigenvals[0]) < 0:
            point_type = "Устойчивый фокус"
        elif np.real(eigenvals[0]) > 0:
            point_type = "Неустойчивый фокус"
        else:
            point_type = "Центр"
    else:
        point_type = "Вырожденный случай"

print(f"Тип особой точки: {point_type}")