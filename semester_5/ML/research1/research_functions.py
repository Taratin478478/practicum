from collections import Counter
from typing import List


def are_multisets_equal(x: List[int], y: List[int]) -> bool:
    """
    Проверить, задают ли два вектора одно и то же мультимножество.
    """
    return sorted(x) == sorted(y)

def max_prod_mod_3(x: List[int]) -> int:
    """
    Вернуть максимальное прозведение соседних элементов в массиве x, 
    таких что хотя бы один множитель в произведении делится на 3.
    Если таких произведений нет, то вернуть -1.
    """
    f = True
    if (len(x)) <= 1:
        return -1
    if (x[0] % 3 == 0):
        if f:
            f = False
            ans = x[0] * x[1]
        else:
            ans = max(ans, x[0] * x[1])
    for i in range(1, len(x) - 1):
        if (x[i] % 3 == 0):
            if f:
                f = False
                ans = max(x[i] * x[i - 1], x[i] * x[i + 1])
            else:
                ans = max(ans, x[i] * x[i - 1], x[i] * x[i + 1])
    if (x[-1] % 3 == 0):
        if f:
            f = False
            ans = x[-1] * x[-2]
        else:
            ans = max(ans, x[-1] * x[-2])
    if f:
        return -1
    else:
        return ans

def convert_image(image: List[List[List[float]]], weights: List[float]) -> List[List[float]]:
    """
    Сложить каналы изображения с указанными весами.
    """
    res = []
    for i in range(len(image)):
        res.append([])
        for j in range(len(image[0])):
            res[-1].append(0)
            for k in range(len(image[0][0])):
                res[-1][-1] += image[i][j][k] * weights[k]
    return res



def rle_scalar(x: List[List[int]], y:  List[List[int]]) -> int:
    """
    Найти скалярное произведение между векторами x и y, заданными в формате RLE.
    В случае несовпадения длин векторов вернуть -1.
    """
    if (len(x) == 0 and len(y) == 0):
        return 0
    if (len(x) == 0 or len(y) == 0):
        return -1
    res = ix = iy = 0
    lx = x[0][1]
    ly = y[0][1]
    while True:
        if lx == 0:
            ix += 1
            if ix == len(x):
                if iy == len(y) - 1 and ly == 0:
                    return res
                else:
                    return -1
            lx = x[ix][1]
        if ly == 0:
            iy += 1
            if (iy == len(y)):
                return -1
            ly = y[iy][1]
        res += x[ix][0] * y[iy][0]
        lx -= 1
        ly -= 1



def cosine_distance(X: List[List[float]], Y: List[List[float]]) -> List[List[float]]:
    """
    Вычислить матрицу косинусных расстояний между объектами X и Y. 
    В случае равенства хотя бы одно из двух векторов 0, косинусное расстояние считать равным 1.
    """
    ans = [[0] * len(Y) for _ in range(len(X))]
    for i in range(len(X)):
        for j in range(len(Y)):
            lx = 0
            ly = 0;
            for k in range(len(X[0])):
                ans[i][j] += X[i][k] * Y[j][k]
                lx += X[i][k] * X[i][k]
                ly += Y[j][k] * Y[j][k]
            if (lx == 0 or ly == 0):
                ans[i][j] = 1
            else:
                ans[i][j] /= (lx ** 0.5) * (ly ** 0.5)
    return ans