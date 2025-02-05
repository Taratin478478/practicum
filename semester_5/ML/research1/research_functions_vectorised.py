import numpy as np


def are_multisets_equal(x: np.ndarray, y: np.ndarray) -> bool:
    """
    Проверить, задают ли два вектора одно и то же мультимножество.
    """
    values1, counts1 = np.unique(x, return_counts=True)
    values2, counts2 = np.unique(y, return_counts=True)
    return np.all(values1 == values2) and np.all(counts1 == counts2)


def max_prod_mod_3(x: np.ndarray) -> int:
    """
    Вернуть максимальное прозведение соседних элементов в массиве x, 
    таких что хотя бы один множитель в произведении делится на 3.
    Если таких произведений нет, то вернуть -1.
    """
    res = (x[1:] * x[:-1])[(x[1:] % 3 == 0) | (x[:-1] % 3 == 0)]
    if len(res) == 0:
        return -1
    else:
        return np.max(res)

def convert_image(image: np.ndarray, weights: np.ndarray) -> np.ndarray:
    """
    Сложить каналы изображения с указанными весами.
    """
    return np.dot(image, weights)


def rle_scalar(x: np.ndarray, y: np.ndarray) -> int:
    """
    Найти скалярное произведение между векторами x и y, заданными в формате RLE.
    В случае несовпадения длин векторов вернуть -1.
    """
    x = np.repeat(x[:, 0], x[:, 1])
    y = np.repeat(y[:, 0], y[:, 1])
    if len(x) != len(y):
        return -1
    else:
        return np.dot(x, y)


def cosine_distance(X: np.ndarray, Y: np.ndarray) -> np.ndarray:
    """
    Вычислить матрицу косинусных расстояний между объектами X и Y.
    В случае равенства хотя бы одно из двух векторов 0, косинусное расстояние считать равным 1.
    """
    N = np.outer(np.linalg.norm(X, axis=1), np.linalg.norm(Y, axis=1))
    return np.where(N > 0, np.dot(X, Y.T) / N, 1)
