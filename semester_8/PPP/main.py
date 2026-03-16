import numpy as np

def solve1():
    f = open("semester_8\\PPP\\data.txt", "r")
    type = f.readline().strip()
    x1, y1, x2, y2 = map(float, f.readline().strip().split())
    N = int(f.readline().strip())
    points = [tuple(map(float, f.readline().strip().split(", "))) for _ in range(N)]
    f.close()

    

def solve2():
    f = open("semester_8\\PPP\\data.txt", "r")
    type = f.readline().strip()
    if type == "rectangle":
        x1, y1, x2, y2 = map(float, f.readline().strip().split())
        N = int(f.readline().strip())
        points = [tuple(map(float, f.readline().strip().split(", "))) for _ in range(N)]
    elif type == "circle":
        x, y, r = map(float, f.readline().strip().split())
        N = int(f.readline().strip())
        points = [tuple(map(float, f.readline().strip().split(", "))) for _ in range(N)]
    f.close()

solve2()