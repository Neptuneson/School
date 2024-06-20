def bisect(f, a, b):
    """Uses bisection method to solve f(x)=0 on the interval [a, b]

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
    e = (b - a) / 2
    fa = f(a)
    fb = f(b)
    i = 2
    # f(a) * f(m) gives 1 when same sign
    if (fa > 0 and fb > 0) or (fa < 0 and fb < 0):
        raise Exception('Invalid interval')
    while i <= 100 and e > 1e-20:
        m = (a + b) / 2
        fm = f(m)
        i = i + 1
        if fa < 0 < fm or fm < 0 < fa:
            # Keep first half
            b = m
        else:
            # Keep second half
            a = m
            fa = fm
        e = (b-a) / 2
        print(f"[{a},{b}]")
    return (a + b) / 2


def newton(f, df, x0):
    """Uses Newton's method to solve f(x)=0 starting at x0

            Parameters
            ----------
            f : lambda statement
                A function
            df : lambda statement
                The derivative of the above function f
            x0 : int or float
                The x-value to start at

            Returns
            -------
            int or float
                A root of f
    """
    err = 1
    i = 0
    while err > 1e-10 and i < 30:
        x1 = x0 - f(x0) / df(x0)
        err = abs(x0 - x1)
        i += 1
        x0 = x1
        print(x0)
    if err < 1e-10:
        return x0
    else:
        raise Exception('Didn\'t converge')


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
    f = lambda x: x ** 3 - 2
    df = lambda x: 3 * x ** 2
    print("Bisection Method")
    print("Bisect: " + str(bisect(f, 1, 2)), end="\n\n")
    # causes invalid interval exception
    # print("Bisect: " + str(bisect(f, 2, 3)), end="\n\n")

    print("Newton's Method")
    print("Newton: " + str(newton(f, df, 2)), end="\n\n")

    print("False Position Method")
    print("False Position: " + str(false_position(f, 1, 2)), end="\n\n")
    # causes invalid interval exception
    # print("False Position: " + str(false_position(f, 2, 3)), end="\n\n")
