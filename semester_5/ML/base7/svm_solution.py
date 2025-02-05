import numpy as np
from sklearn.svm import SVC
from sklearn.model_selection import GridSearchCV


def train_svm_and_predict(train_features, train_target, test_features):
    """
    train_features: np.array, (num_elements_train x num_features) - train data description, the same features and the same order as in train data
    train_target: np.array, (num_elements_train) - train data target
    test_features: np.array, (num_elements_test x num_features) -- some test data, features are in the same order as train features

    return: np.array, (num_elements_test) - test data predicted target, 1d array
    """
    """
    parameters = [{'C': [9, 10, 11, 12, 13, 14], 'kernel': ('linear', 'rbf')},
     {'C': np.logspace(-3, 3, 7), 'kernel': ['poly'], 'degree': [2, 3], 'coef0': [0, 2, 5, 7, 10]}]

    grid_search = GridSearchCV(SVC(), param_grid=parameters, scoring='accuracy', cv=3, n_jobs=-1, verbose=0)
    grid_search.fit(train_features, train_target)

    print(grid_search.best_params_)
    test_target = grid_search.predict(test_features)
    print(test_target)
    """
    model = SVC(C=10, kernel='poly', coef0=2, degree=2)
    model.fit(train_features, train_target)
    test_target = model.predict(test_features)

    return test_target
