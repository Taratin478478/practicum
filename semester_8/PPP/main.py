import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

# Параметры
DATA_PATH = "semester_8/PPP/data.txt"
OUT_PATH = "semester_8/PPP/ex6.eps"
objective_name = "min"   # варианты: "sum", "sum_sq", "min", "inv"
grid_res = (200, 200)    # (nx, ny)
eps = 1e-12
show_traj = False
sigma = 1.0
min_T = 1e-8
m_per_T = 100
k = 0.95

# --- чтение файла ---
with open(DATA_PATH, "r", encoding="utf-8") as f:
    task = f.readline().strip()
    if task == "1":
        shape = f.readline().strip()
        x1, y1, x2, y2 = map(float, f.readline().strip().split())
        N = int(f.readline().strip())
        raw_points = [tuple(map(float, f.readline().strip().replace(',', ' ').split())) for _ in range(N)]
    elif task == "2":
        shape = f.readline().strip()
        if shape == "rectangle":
            x1, y1, x2, y2 = map(float, f.readline().strip().split())
            x0, y0 = (x1 + x2) / 2, (y1 + y2) / 2
            T = np.max([np.abs(x1-x2), np.abs(y1-y2)])
            N = int(f.readline().strip())
            raw_points = [tuple(map(float, f.readline().strip().replace(',', ' ').split())) for _ in range(N)]
        elif shape == "circle":
            x0, y0, r = map(float, f.readline().strip().split())
            T = r
            N = int(f.readline().strip())
            raw_points = [tuple(map(float, f.readline().strip().replace(',', ' ').split())) for _ in range(N)]
        else:
            raise ValueError("Unknown shape in task 2")
    else:
        raise ValueError("Unknown task")

# проверка наличия точек
if len(raw_points) == 0:
    raise ValueError("No points provided in data file")

# --- привести к трём массивам: xs_pts, ys_pts, weights ---
processed = []
for p in raw_points:
    if len(p) >= 3:
        processed.append((p[0], p[1], p[2]))
    else:
        processed.append((p[0], p[1], 1.0))
pts_arr = np.array(processed, dtype=float)
xs_pts = pts_arr[:,0]
ys_pts = pts_arr[:,1]
weights = pts_arr[:,2]

# при task == "1" все веса = 1
if task == "1":
    weights = np.ones_like(weights)

# --- границы и in_shape ---
if shape == "circle":
    xmin, xmax = x0 - r, x0 + r
    ymin, ymax = y0 - r, y0 + r
    in_shape = lambda xi, yi: (xi - x0)**2 + (yi - y0)**2 <= r**2 + 1e-12
else:  # rectangle
    xmin, xmax = min(x1, x2), max(x1, x2)
    ymin, ymax = min(y1, y2), max(y1, y2)
    in_shape = lambda xi, yi: (xmin <= xi <= xmax) and (ymin <= yi <= ymax)

# --- функции-цели (возвращают число; цель — максимизировать) ---
def obj_sum(x, y):
    d = np.hypot(xs_pts - x, ys_pts - y)
    return np.sum(weights * d)

def obj_sum_sq(x, y):
    d2 = (xs_pts - x)**2 + (ys_pts - y)**2
    return np.sum(weights * d2)

def obj_min(x, y):
    # Для максимизации минимального расстояния возвращаем минимус минимального расстояния
    d = np.hypot(xs_pts - x, ys_pts - y)
    return np.min(d / (weights + eps))

def obj_inv(x, y):
    d = np.hypot(xs_pts - x, ys_pts - y)
    return 1 / np.sum(weights / (d + eps))

objectives = {
    "sum": obj_sum,
    "sum_sq": obj_sum_sq,
    "min": obj_min,
    "inv": obj_inv
}

if objective_name not in objectives:
    raise ValueError("Unknown objective: " + objective_name)

obj = objectives[objective_name]

# --- выбор стартовой точки случайно внутри области ---
def random_point_inside(max_tries=100000):
    for _ in range(max_tries):
        xi = np.random.uniform(xmin, xmax)
        yi = np.random.uniform(ymin, ymax)
        if in_shape(xi, yi):
            return xi, yi
    raise RuntimeError("Failed to sample a point inside the shape")

# инициализация T (если не задана из файла)
if 'T' not in locals() or T is None:
    T = max(xmax - xmin, ymax - ymin)

x, y = random_point_inside()

# --- simulated annealing (максимизация) ---
xs_traj, ys_traj = [x], [y]
# более стабильный отжиг для "min"
T0 = 0.25 * np.hypot(xmax - xmin, ymax - ymin)
T = T0
step0 = 0.25 * max(xmax - xmin, ymax - ymin)


x, y = random_point_inside()
f_current = obj(x, y)
xs_traj, ys_traj = [x], [y]

while T > min_T:
    step_scale = max(1e-12, step0 * (T / T0))
    for _ in range(m_per_T):
        xi = np.random.normal(x, step_scale)
        yi = np.random.normal(y, step_scale)
        if not in_shape(xi, yi):
            continue
        f_new = obj(xi, yi)
        df = f_new - f_current
        if df >= 0 or np.random.rand() < np.exp(df / (T + eps)):
            x, y = xi, yi
            f_current = f_new
            xs_traj.append(x); ys_traj.append(y)
            # локальная дооптимизация по 8 направлениям
            improved = True
            local_step = step_scale * 0.5
            while improved and local_step > 1e-6:
                improved = False
                for ang in np.linspace(0, 2*np.pi, 8, endpoint=False):
                    xx = x + local_step * np.cos(ang)
                    yy = y + local_step * np.sin(ang)
                    if not in_shape(xx, yy):
                        continue
                    ff = obj(xx, yy)
                    if ff > f_current:  
                        x, y = xx, yy
                        f_current = ff
                        xs_traj.append(x); ys_traj.append(y)
                        improved = True
                if not improved:
                    local_step *= 0.5
    T *= k


# --- вычисление карты цели на сетке ---
nx, ny = grid_res
gx = np.linspace(xmin, xmax, nx)
gy = np.linspace(ymin, ymax, ny)
GX, GY = np.meshgrid(gx, gy)

coords_x = xs_pts.reshape(1,1,-1)
coords_y = ys_pts.reshape(1,1,-1)
w = weights.reshape(1,1,-1)
DX = coords_x - GX[:,:,np.newaxis]
DY = coords_y - GY[:,:,np.newaxis]
D = np.sqrt(DX*DX + DY*DY)


if objective_name == "sum":
    Z = np.sum(w * D, axis=2)
elif objective_name == "sum_sq":
    Z = np.sum(w * (D**2), axis=2)
elif objective_name == "min":
    Z = np.min(D / (w + eps), axis=2)
elif objective_name == "inv":
    Z = 1 / np.sum(w / (D + eps), axis=2)
else:
    Z = np.sum(w * D, axis=2)

# --- визуализация ---
fig, ax = plt.subplots(figsize=(8,8))
cf = ax.contourf(GX, GY, Z, levels=60, cmap='viridis', alpha=0.9)
cbar = fig.colorbar(cf, ax=ax, shrink=0.8)
cbar.set_label(objective_name, fontsize=10)

if shape == "circle":
    circle = Circle((x0, y0), r, edgecolor='k', facecolor='none', linewidth=1.5)
    ax.add_patch(circle)
# точки: размеры по весу
weights_arr = np.asarray(weights)
if np.ptp(weights_arr) == 0:
    norm_w = np.zeros_like(weights_arr)
else:
    norm_w = (weights_arr - weights_arr.min()) / np.ptp(weights_arr)
sizes = 40 + 200 * norm_w
ax.scatter(xs_pts, ys_pts, s=sizes, c='white', edgecolors='k', linewidth=0.6, zorder=5, label='points (size ~ weight)')

# траектория
if show_traj and len(xs_traj) > 1:
    for i in range(len(xs_traj) - 1):
        cr = i / (len(xs_traj) - 2) if len(xs_traj) > 2 else 0.5
        color = (1 - cr, 0, cr)
        ax.plot([xs_traj[i], xs_traj[i+1]], [ys_traj[i], ys_traj[i+1]], color=color, linewidth=2, alpha=0.9, zorder=6)
    ax.plot(xs_traj, ys_traj, 'k.', markersize=4, zorder=7)

# финальная точка
ax.plot(x, y, marker='*', color='red', markersize=12, markeredgecolor='k', zorder=10, label='final')

ax.set_xlim(xmin, xmax)
ax.set_ylim(ymin, ymax)
ax.set_aspect('equal', 'box')
ax.grid(alpha=0.3)
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title(f'Objective: {objective_name} — map, points and trajectory')
ax.legend(loc='upper right', fontsize=9)
plt.tight_layout()
plt.savefig(OUT_PATH, dpi=300)
plt.show()
