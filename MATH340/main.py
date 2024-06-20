import math
import numpy as numpy
import matplotlib.pyplot as plt


def newton(x, epsilon=1e-10, iterations=30):
    i = 0
    while abs(6*math.sin(x)-x) > epsilon and i < iterations:
        x = x - (6*math.sin(x)-x)/(6*math.cos(x)-1)
        i += 1
        #print(f'{i}: {x}')
    if abs(6*math.sin(x)-x) > epsilon:
        print('Diverges')
    return x


def secant(x0, x1, epsilon=1e-10, iterations=30):
    i = 0
    while (6*math.sin(x1)-x1)-(6*math.sin(x0)-x0) != 0 and i < iterations:
        x2 = x1 - ((6*math.sin(x1)-x1)*(x1-x0)) / ((6*math.sin(x1)-x1)-(6*math.sin(x0)-x0))
        i += 1
        print(f'{i}: {x2}')
        x0 = x1
        x1 = x2
    return x2


if __name__ == '__main__':
    xs = numpy.linspace(-5, 5, 100)
    ys = []
    for x in xs:
        ys.append(secant(x, x+1))
    print(xs)
    print(ys)
    plt.plot(xs, ys)
    plt.xlabel('x0')
    plt.ylabel('xi')
    plt.grid()
    plt.show()

