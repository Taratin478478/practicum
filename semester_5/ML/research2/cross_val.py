import numpy as np
import typing
from collections import defaultdict


def kfold_split(num_objects: int,
                num_folds: int) -> list[tuple[np.ndarray, np.ndarray]]:
    """Split [0, 1, ..., num_objects - 1] into equal num_folds folds
       (last fold can be longer) and returns num_folds train-val
       pairs of indexes.

    Parameters:
    num_objects: number of objects in train set
    num_folds: number of folds for cross-validation split

    Returns:
    list of length num_folds, where i-th element of list
    contains tuple of 2 numpy arrays, he 1st numpy array
    contains all indexes without i-th fold while the 2nd
    one contains i-th fold
    """
    fold_size = num_objects // num_folds
    res = list()
    for i in range(num_folds - 1):
        res.append(
            (np.append(
                np.arange(
                    0,
                    i * fold_size),
                np.arange(
                    (i + 1) * fold_size,
                    num_objects)),
                np.arange(
                i * fold_size,
                (i + 1) * fold_size)))
    res.append(
        (np.arange(
            0,
            (num_folds - 1) * fold_size),
            np.arange(
            (num_folds - 1) * fold_size,
            num_objects)))
    return res


def knn_cv_score(X: np.ndarray, y: np.ndarray, parameters: dict[str, list],
                 score_function: callable,
                 folds: list[tuple[np.ndarray, np.ndarray]],
                 knn_class: object) -> dict[str, float]:
    """Takes train data, counts cross-validation score over
    grid of parameters (all possible parameters combinations)

    Parameters:
    X: train set
    y: train labels
    parameters: dict with keys from
        {n_neighbors, metrics, weights, normalizers}, values of type list,
        parameters['normalizers'] contains tuples (normalizer, normalizer_name)
        see parameters example in your jupyter notebook

    score_function: function with input (y_true, y_predict)
        which outputs score metric
    folds: output of kfold_split
    knn_class: class of knn model to fit

    Returns:
    dict: key - tuple of (normalizer_name, n_neighbors, metric, weight),
    value - mean score over all folds
    """
    res = dict()
    for n_neighbors in parameters["n_neighbors"]:
        for metric in parameters["metrics"]:
            for weight in parameters["weights"]:
                for normalizer in parameters["normalizers"]:
                    score = 0
                    for fold in folds:
                        X_train = X[fold[0]]
                        y_train = y[fold[0]]
                        X_test = X[fold[1]]
                        y_test = y[fold[1]]
                        if normalizer[0] is not None:
                            normalizer[0].fit(X_train)
                            X_train = normalizer[0].transform(X_train)
                            X_test = normalizer[0].transform(X_test)
                        model = knn_class(
                            n_neighbors=n_neighbors, metric=metric, weights=weight)
                        model.fit(X_train, y_train)
                        y_pred = model.predict(X_test)
                        score += score_function(y_test, y_pred)
                    score /= len(folds)
                    res[(normalizer[1], n_neighbors, metric, weight)] = score
    return res
