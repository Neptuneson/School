#include <stdio.h>
#include <stdlib.h>

typedef enum {
    INT,
    FLOAT,
    DOUBLE
} tag_t;

typedef union {
    int i;
    float f;
    double d;
} value_t;

typedef struct {
    tag_t tag;
    value_t value;
} number_t;

number_t
create_int (int i)
{
    number_t n;
    n.tag = INT;
    n.value.i = i;
    return n;
};

number_t
create_float (float f)
{
    number_t n;
    n.tag = FLOAT;
    n.value.f = f;
    return n;
};

number_t
create_double (double d)
{
    number_t n;
    n.tag = DOUBLE;
    n.value.d = d;
    return n;
};

number_t
negate(number_t n)
{
    number_t negated;
    negated.tag = n.tag;
    if (n.tag == INT)
        negated.value.i = n.value.i * -1;
    else if (n.tag == FLOAT)
        negated.value.f = n.value.f * -1;
    else if (n.tag == DOUBLE)
        negated.value.d = n.value.d * -1;
    return negated;
};

number_t
add(number_t n1, number_t n2)
{
    number_t added;
    if (n1.tag == n2.tag) {
        added.tag = n1.tag;
        if (n1.tag == INT)
            added.value.i = n1.value.i + n2.value.i;
        else if (n1.tag == FLOAT)
            added.value.f = n1.value.f + n2.value.f;
        else if (n1.tag == DOUBLE)
            added.value.d = n1.value.d + n2.value.d;
    } else {
        perror("Types are not the same");
    }
    return added;
};

int
main (int argc, char **argv)
{
    number_t n1 = create_int(1);
    number_t n2 = create_float(1.1);
    number_t n3 = create_double(1.1);

    printf("\nNegate\n");
    number_t negate1 = negate(n1);
    printf("%d\n", negate1.value.i);
    number_t negate2 = negate(n2);
    printf("%f\n", negate2.value.f);
    number_t negate3 = negate(n3);
    printf("%lf\n", negate3.value.d);

    printf("\nAdd\n");
    number_t add1 = add(n1, n1);
    printf("%d\n", add1.value.i);
    number_t add2 = add(n2, n2);
    printf("%f\n", add2.value.f);
    number_t add3 = add(n3, n3);
    printf("%lf\n", add3.value.d);

    number_t addf = add(n1,n2);

    return 0;
}
