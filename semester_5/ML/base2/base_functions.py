from typing import List
from copy import deepcopy


def get_part_of_array(X: List[List[float]]) -> List[List[float]]:
    """
    X - двумерный массив вещественных чисел размера n x m. Гарантируется что m >= 500
    Вернуть: двумерный массив, состоящий из каждого 4го элемента по оси размерности n 
    и c 120 по 500 c шагом 5 по оси размерности m
    """
    ans = []
    for i in range(0, len(X), 4):
        ans.append([])
        for j in range(120, min(len(X[0]), 500), 5):
            ans[-1].append(X[i][j])
    return ans


def sum_non_neg_diag(X: List[List[int]]) -> int:
    """
    Вернуть  сумму неотрицательных элементов на диагонали прямоугольной матрицы X. 
    Если неотрицательных элементов на диагонали нет, то вернуть -1
    """
    f = False
    ans = 0
    for i in range(min(len(X), len(X[0]))):
        if X[i][i] >= 0:
            ans += X[i][i]
            f = True
    if f:
        return ans
    else:
        return -1

def replace_values(X: List[List[float]]) -> List[List[float]]:
    """
    X - двумерный массив вещественных чисел размера n x m.
    По каждому столбцу нужно почитать среднее значение M.
    В каждом столбце отдельно заменить: значения, которые < 0.25M или > 1.5M на -1
    Вернуть: двумерный массив, копию от X, с измененными значениями по правилу выше
    """
    M = [0] * len(X[0])
    for i in range(len(X)):
        for j in range(len(X[0])):
            M[j] += X[i][j]
    res = deepcopy(X)
    for j in range(len(M)):
        M[j] /= len(X)
        for i in range(len(X)):
            if res[i][j] < 0.25 * M[j] or res[i][j] > 1.5 * M[j]:
                res[i][j] = -1
    return res