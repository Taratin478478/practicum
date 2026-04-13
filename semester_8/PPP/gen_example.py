N = 10
task = 1 # 1 or 2
type = "rectangle" # "rectangle" or "circle"
x1, x2, y1, y2 = -100, 100, -100, 100
x, y, r = 0, 0, 100

with open('semester_8/PPP/data.txt', 'w') as f:
    f.write(f"{task}\n")
    f.write(f"{type}\n")
    f.write(f"{x1} {y1} {x2} {y2}\n")
    f.write(f"{N**2 - 1}\n")
    for i in range(N):
        for j in range(N):
            if not (i == 3 and j == 7):
                f.write(f"{x1 + i * (x2 - x1) / (N - 1)}, {y1 + j * (y2 - y1) / (N - 1)}\n")