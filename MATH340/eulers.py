import math

from matplotlib import pyplot as plt


def euler(df, t0, y0, delta_t, iterations=30):
    t_s = [t0]
    y_s = [y0]
    t_i = t0
    y_i = y0
    for _ in range(iterations):
        t_j = t_i + delta_t
        y_j = df(t_i, y_i) * delta_t + y_i
        t_s.append(t_j)
        y_s.append(y_j)
        t_i = t_j
        y_i = y_j

    return t_s, y_s


if __name__ == '__main__':
    def f(_, y): return 2*y-1
    ts, ys = euler(f, 0, 1, 0.01, iterations=1000)

    def g(t): return (math.exp(2 * t) + 1) / 2
    plt.plot(ts, ys, label="Approximation")
    plt.plot(ts, [g(t) for t in ts], label="Exact")
    plt.legend()
    plt.grid()
    plt.show()
