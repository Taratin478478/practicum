import random
import numpy as np

N = 100
task = 2 # 1 or 2
type = "circle" # "rectangle" or "circle"
x1, x2, y1, y2 = -100, 100, -100, 100
x, y, r = 0, 0, 100

with open('semester_8/PPP/data.txt', 'w') as f:
    f.write(f"{task}\n")
    if task == 1:
        f.write(f"{type}\n")
        f.write(f"{x1} {y1} {x2} {y2}\n")
        f.write(f"{N}\n")
        for _ in range(N):
            f.write(f"{random.uniform(x1, x2)}, {random.uniform(y1, y2)}\n")
    if task == 2:
        f.write(f"{type}\n")
        if type == "circle":
            f.write(f"{x} {y} {r}\n")
            f.write(f"{N}\n")
            for _ in range(N):
                phi = random.uniform(0, 2 * np.pi)
                R = random.uniform(0, r)
                f.write(f"{x + R * np.cos(phi)}, {y + R * np.sin(phi)}, {random.uniform(0, 100)}\n")
        elif type == "rectangle":
            f.write(f"{x1} {y1} {x2} {y2}\n")
            f.write(f"{N}\n")
            for _ in range(N):
                f.write(f"{random.uniform(x1, x2)}, {random.uniform(y1, y2)}, {random.uniform(0, 100)}\n")