import scipy
import statistics
from scipy import stats

import numpy as np

if __name__ == '__main__':
    var = np.var([2.3, 1.9, 0.3, 2.9, 3.1, 2.5])
    mean = np.mean([2.3, 1.9, 0.3, 2.9, 3.1, 2.5])
    print(scipy.stats.norm(mean, var).pdf(1.9))
