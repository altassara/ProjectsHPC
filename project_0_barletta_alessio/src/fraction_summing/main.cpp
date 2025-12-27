#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#include "fraction_toolbox.hpp"

using namespace std;

// read command line arguments
static void readcmdline(fraction & frac, int argc, char* argv[])
{
    if (argc!=3)
    {
        printf("Usage: n d\n");
        printf("  n        numerator of fraction\n");
        printf("  d        denominator of fraction\n");
        exit(1);
    }

    // read n
    frac.num = atoi(argv[1]);

    // read d
    frac.denom = atoi(argv[2]);
}

static void test23467(int argc, char* argv[])
{
    fraction frac;
    readcmdline(frac, argc, argv);

    cout << "Input fraction: ";
    print_fraction(frac);

    fraction frac_squared = square_fraction(frac);
    cout << "Testing function 2 (square_fraction): ";
    print_fraction(frac_squared);

    fraction frac_squared_inplace = frac;
    square_fraction_inplace(frac_squared_inplace);
    cout << "Testing function 3 (square_fraction_inplace): ";
    print_fraction(frac_squared_inplace);

    double frac_as_double = fraction2double(frac);
    cout << "Testing function 4 (fraction2double): " << frac_as_double << endl;

    int divisor = gcd(frac);
    cout << "Testing function 6 (gcd fraction as input): " << divisor << endl;

    reduce_fraction_inplace(frac);
    cout << "Testing function 7 (reduce_fraction_inplace): ";
    print_fraction(frac);
}

static void test5()
{
    cout << "insert two integers: ";
    int a, b;
    cin >> a >> b;
    cout << "Testing function 5 (gcd with two integers as input): " << gcd(a, b) << endl;
}

static void test_array_functions(int n)
{
    fraction* frac_array = (fraction*)malloc(n * sizeof(fraction));
    fill_fraction_array(frac_array, n);

    cout << "testing sum_fraction_array: ";
    fraction sum = sum_fraction_array(frac_array, n);
    print_fraction(sum);

    cout << "testing sum_fraction_array_approx: " << sum_fraction_array_approx(frac_array, n) << endl;
    
    /*
    n = 1290 is where the sum functions breaks.
    This is due to how I implemented it, the limit of the int type and the way the frac_array is filled.
    In particular, the frac_array is filled with fractions of the form 1/i(i+1) where i goes from 1 to n. This is a telescoping series that converges to 1.
    For this series, the nth partial sum S_n = n/(n+1).

    The way i implemented the sum_fraction (which is called in the sum_fraction_array function) is the simple method to sum fraction,
    so to get the denominator of the result I multiply the two denominators of the fractions being added.

    The limit of the int type is 2^31 - 1 = 2147483647, so what i need to do is to find the smallest n such that (n)(n(n+1)) > 2147483647.

    I found this number to be 1290, so for n = 1290 the sum function breaks.

    This problem is not happening in the sum_fraction_array_approx function because every fraction is converted to double before being summed,
    and the result is a double too, so the limit where the function breaks is much higher.
    */
}

static void test_toolbox(int argc, char* argv[])
{
    cout << "\n===============  test23467  =============== " << endl;
    test23467(argc, argv);

    cout << "\n=================  test5  ================= " << endl;
    test5();

    cout << "\n==========  test_array_functions  ========= " << endl;
    int n = 5; //1290 is where the sum functions breaks
    test_array_functions(n);
}

int main(int argc, char* argv[])
{
    test_toolbox(argc, argv);

    return 0;
    
}