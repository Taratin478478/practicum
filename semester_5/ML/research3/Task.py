import numpy as np


class Preprocessor:

    def __init__(self):
        pass

    def fit(self, X, Y=None):
        pass

    def transform(self, X):
        pass

    def fit_transform(self, X, Y=None):
        pass


class MyOneHotEncoder(Preprocessor):

    def __init__(self, dtype=np.float64):
        super(Preprocessor).__init__()
        self.dtype = dtype
        self.values = []

    def fit(self, X, Y=None):
        """
        param X: training objects, pandas-dataframe, shape [n_objects, n_features]
        param Y: unused
        """
        for i in range(0, len(X.columns)):
            self.values.append(sorted(X[X.columns[i]].unique()))

    def transform(self, X):
        """
        param X: objects to transform, pandas-dataframe, shape [n_objects, n_features]
        returns: transformed objects, numpy-array, shape [n_objects, |f1| + |f2| + ...]
        """
        valuesarr = []
        for v in self.values:
            valuesarr.extend(v)
        Y = np.zeros([len(X), len(valuesarr)], dtype=self.dtype)
        X = X.to_numpy()
        k = 0
        for row in X:
            b = 0
            r = 0
            for x in row:
                for val in self.values[r]:
                    if val == x:
                        Y[k][b] = 1
                    b += 1
                r += 1
            k += 1
        return Y

    def fit_transform(self, X, Y=None):
        self.fit(X)
        return self.transform(X)

    def get_params(self, deep=True):
        return {"dtype": self.dtype}


class SimpleCounterEncoder:
    def __init__(self, dtype=np.float64):
        self.dtype = dtype
        self.feature_stats = []

    def fit(self, X, Y):
        X_array = X.to_numpy()
        Y_array = Y.to_numpy()
        self.feature_stats = []

        for column in range(X_array.shape[1]):
            unique_values = np.unique(X_array[:, column])
            stats = {}
            for value in unique_values:
                count_x = 0
                sum_y = 0
                for row in range(X_array.shape[0]):
                    if X_array[row][column] == value:
                        count_x += 1
                        sum_y += Y_array[row]
                stats[value] = [sum_y / count_x, count_x / len(X_array), 0]
            self.feature_stats.append(stats)

    def transform(self, X, a=1e-5, b=1e-5):
        transformed = np.array([])
        X_array = X.to_numpy()

        for column in range(X_array.shape[1]):
            column_result = np.zeros((X_array.shape[0], 3))
            for row in range(X_array.shape[0]):
                column_result[row] = self.feature_stats[column][X_array[row][column]].copy(
                )
                column_result[row][2] = (
                    column_result[row][0] + a) / (column_result[row][1] + b)

            if transformed.size == 0:
                transformed = column_result
            else:
                transformed = np.hstack((transformed, column_result))

        return transformed

    def fit_transform(self, X, Y, a=1e-5, b=1e-5):
        self.fit(X, Y)
        return self.transform(X, a, b)

    def get_params(self, deep=True):
        return {"dtype": self.dtype}


def group_k_fold(data_size, n_splits=3, seed=1):
    indices = np.arange(data_size)
    np.random.seed(seed)
    np.random.shuffle(indices)
    fold_size = data_size // n_splits

    for i in range(n_splits - 1):
        test_indices = indices[i * fold_size:(i + 1) * fold_size]
        train_indices = np.concatenate(
            (indices[:i * fold_size], indices[(i + 1) * fold_size:]))
        yield test_indices, train_indices

    yield indices[(n_splits - 1) * fold_size:], indices[:(n_splits - 1) * fold_size]


class FoldCounters:
    def __init__(self, n_folds=3, dtype=np.float64):
        self.n_folds = n_folds
        self.dtype = dtype
        self.fold_encoders = []

    def fit(self, X, Y, seed=1):
        X_array = X.to_numpy()
        self.fold_encoders = []

        for test_idx, train_idx in group_k_fold(
                X_array.shape[0], self.n_folds, seed):
            encoder = SimpleCounterEncoder(dtype=self.dtype)
            encoder.fit(X.iloc[train_idx], Y.iloc[train_idx])
            self.fold_encoders.append((test_idx, encoder))

    def transform(self, X, a=1e-5, b=1e-5):
        result = np.zeros((X.shape[0], 3 * X.shape[1]))

        for test_idx, encoder in self.fold_encoders:
            result[test_idx] = encoder.transform(X.iloc[test_idx], a, b)

        return result

    def fit_transform(self, X, Y, a=1e-5, b=1e-5):
        self.fit(X, Y)
        return self.transform(X, a, b)


def weights(values, target):
    unique_values = np.unique(values)
    weight_array = np.zeros(len(unique_values))

    for idx, val in enumerate(unique_values):
        mask = values == val
        weight_array[idx] = target[mask].sum() / mask.sum()

    return weight_array
