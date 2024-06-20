import math


def false_position(f, a, b):
    """Uses false_position method to solve f(x)=0 on the interval [a, b]

                Parameters
                ----------
                f : lambda statement
                    A function
                a : int or float
                    The left side of the interval
                b : int or float
                    The right side of the interval

                Returns
                -------
                int or float
                    A root of f
    """
    fa = f(a)
    fb = f(b)
    if (fa > 0 and fb > 0) or (fa < 0 and fb < 0):  # Check for valid interval
        raise Exception('Not a valid interval')
    side = 0  # Side will hold if last step was on left(-1) or right(1)
    while (b - a) > 1e-12:
        c = (fa * b - fb * a) / (fa - fb)
        fc = f(c)
        if (fc > 0 and fa > 0) or (fc < 0 and fa < 0):
            a = c
            fa = fc  # a and c are on the same side of the x-axis
            if side == 1:
                fb = fb / 2
            side = 1
        else:
            b = c
            fb = fc  # b and c are on the same side of the x-axis
            if side == -1:
                fa = fa / 2
            side = 1
            print(f"[{a},{b}]")
    return (a + b) / 2


if __name__ == '__main__':
    def f1(x): return x ** 3 - 2
    def f2(x): return 6*math.sin(x)-x

    print("False Position of  x^3-2=0: " + str(false_position(f1, 1, 2)), end="\n\n")
    print("False Position of 6sin(x)-x=0: " + str(false_position(f2, 2, 3)), end="\n\n")
    # causes invalid interval exception
    # print("False Position: " + str(false_position(f, 2, 3)), end="\n\n")