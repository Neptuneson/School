def cubic_min(f, df, a: float, b: float):
    """Uses cubic method to find the minimum of f(x) on the interval [a, b]

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
                A min of f
    """
    if (df(a) > 0 and df(b) < 0) or (df(a) < 0 and df(b) < 0):
        raise Exception('Invalid interval')

    i = 2
    e = (b - a) / 2
    while i <= 100 and e > 1e-12:
        alpha = f(a)
        beta = df(a)

        # finding c
        h = b - a
        F = f(b) - alpha - beta * h
        G = h * df(b) - beta

        gamma = (1 / (h ** 2)) * (3 * F - G)
        delta = (1 / (h ** 3)) * (G - 2 * F)

        if delta > 0:
            c = a + ((-gamma) / (3 * delta)) + ((gamma / (3 * delta)) ** 2 - (beta / (3 * delta))) ** (1 / 2)
        elif delta < 0:
            c = a + ((-gamma) / (3 * delta)) - ((gamma / (3 * delta)) ** 2 - (beta / (3 * delta))) ** (1 / 2)
        else:
            raise Exception('Panic!')

        fc = f(c)
        i += 1

        if df(c) > 0:  # Keep first half
            b = c
        else:  # Keep second half
            a = c
        e = (b - a) / 2
        print(f"[{a},{b}]")

    return (a + b) / 2


if __name__ == '__main__':
    def f(x): return x ** 2 - (1/9) * x
    def df(x): return 2 * x - (1/9)
    print("Cubic Method")
    print("Cubic: " + str(cubic_min(f, df, -2, 2)))
    # causes invalid interval exception
    # print("Bisect: " + str(bisect(f, 2, 3)), end="\n\n")
