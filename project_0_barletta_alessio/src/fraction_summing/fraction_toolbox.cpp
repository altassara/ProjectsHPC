#include <iostream>

#include "fraction_toolbox.hpp"

void print_fraction(fraction frac)
{
    std::cout << frac.num << '/' << frac.denom << std::endl;
}

void print_fraction_array(fraction frac_array[], int n)
{
    std::cout << "[ " << frac_array[0].num << '/' << frac_array[0].denom << std::endl;
    for (int i = 1; i < n-1; i++)
    {
        std::cout << "  ";
        print_fraction(frac_array[i]);
    }
    std::cout << "  " << frac_array[n-1].num << '/' << frac_array[n-1].denom << " ]" << std::endl;
}

fraction square_fraction(fraction frac)
{
    fraction result;
    result.num = frac.num * frac.num;
    result.denom = frac.denom * frac.denom;
    return result;
}

void square_fraction_inplace(fraction &frac)
{
    frac.num = frac.num * frac.num;
    frac.denom = frac.denom * frac.denom;
}

double fraction2double(fraction frac)
{
    return static_cast<double>(frac.num) / frac.denom;
}

int gcd(int a, int b)
{
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

int gcd(fraction frac)
{
    int t;
    while(frac.denom != 0){
        t = frac.denom;
        frac.denom = frac.num % frac.denom;
        frac.num = t;
    }
    return frac.num;
}


void reduce_fraction_inplace(fraction & frac)
{
    //the code is using the function gcd defined at line 47 because it is the one that takes a fraction as input
    int divisor = gcd(frac);
    frac.num /= divisor;
    frac.denom /= divisor;
}

fraction add_fractions(fraction frac1, fraction frac2)
{
    fraction result;
    result.num = frac1.num * frac2.denom + frac2.num * frac1.denom;
    result.denom = frac1.denom * frac2.denom;
    reduce_fraction_inplace(result);
    return result;
}

double sum_fraction_array_approx(fraction frac_array[], int n)
{
    double result = 0;

    for (int i = 0; i < n; i++)
    {
        result +=  fraction2double(frac_array[i]);
    }
    return result;

    // This function returns an approximate value because it uses the fraction2double function
    // which converts the fraction to a double, leading to a possible loss of precision for some fractions.
    // Moreover the error of every approximation is accumulated in the final result.
}

fraction sum_fraction_array(fraction frac_array[], int n)
{
    fraction result;
    result.num = 0;
    result.denom = 1;
    for (int i = 0; i < n; i++)
    {
        result = add_fractions(result, frac_array[i]);
    }
    return result;
}

void fill_fraction_array(fraction frac_array[], int n)
{
    fraction temp_frac;
    temp_frac.num = 1;
    for (int i = 1; i <= n; i++)
    {
        temp_frac.denom = i * (i+1);
        frac_array[i-1] = temp_frac;
    }
}

