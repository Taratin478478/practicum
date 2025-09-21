import numpy as np


def evaluate_measures(sample):
    sample = np.array(sample)
    classes, counts = np.unique(sample, return_counts=True)
    prob = counts / len(sample)
    measures = {
        "gini": float(1 - np.sum(prob ** 2)),
        "entropy": float(-np.sum(prob * np.log(prob))),
        "error": float(1 - np.max(prob))
    }
    return measures
