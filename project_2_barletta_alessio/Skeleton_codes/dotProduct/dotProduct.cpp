#include <omp.h>
#include "walltime.h"
#include <iostream>
#include <math.h>
#include <stdio.h>
#include <unistd.h>

#define NUM_ITERATIONS 100

// Example benchmarks
// 0.008s ~0.8MB
#define N 100000
// 0.1s ~8MB
// #define N 1000000
// 1.1s ~80MB
// #define N 10000000
// 13s ~800MB
// #define N 100000000
// 127s 16GB
//#define N 1000000000
#define EPSILON 0.1

double serial_dot_product(double *a, double *b, int n, double* time_serial);
double parallel_dot_product_reduction(double *a, double *b, int n, double* time_red);
double parallel_dot_product_critical(double *a, double *b, int n, double* time_critical);

using namespace std;

int main() {
  double time_serial, time_start = 0.0;
  double *a, *b;

  long double alpha = 0;
  // serial execution
  // Note that we do extra iterations to reduce relative timing overhead
  //cout << "Serial execution time = " << time_serial << " sec" << endl;

  long double alpha_parallel = 0;
  double time_red = 0;
  double time_critical = 0;

  //   TODO: Write parallel version (2 ways!)
  //   i.  Using reduction pragma
  //   ii. Using  critical pragma

  for(int n : {100000, 1000000, 10000000, 100000000, 1000000000}){

    a = new double[n];
    b = new double[n];

    for (int i = 0; i < n; i++) {
      a[i] = i;
      b[i] = i / 10.0;
    }

    time_serial = 0;
    alpha = serial_dot_product(a, b, n, &time_serial);  


    for(int t : {1, 2, 4, 8, 16, 20}){
      omp_set_num_threads(t);
      time_red = 0;
      time_critical = 0;
      alpha_parallel = parallel_dot_product_reduction(a, b, n, &time_red);
      alpha_parallel = parallel_dot_product_critical(a, b, n, &time_critical);

      if ((fabs(alpha_parallel - alpha) / fabs(alpha_parallel)) > EPSILON) {
        cout << "parallel reduction: " << alpha_parallel << ", serial: " << alpha
            << "\n";
        cerr << "Alpha not yet implemented correctly!\n";
        exit(1);
      }

      cout << "size:\t\t" << n
        << "\t\tthreads: \t\t" << omp_get_max_threads()
        << "\t\tserial = \t\t" << time_serial
        << "\t\treduction = \t\t" << time_red
        << "\t\tcritical = \t\t" << time_critical
        << endl;
    }
    cout << "----------------------------------------" << endl;

    // De-allocate memory
    delete[] a;
    delete[] b;
  }

  return 0;
}


double serial_dot_product(double *a, double *b, int n, double* time_serial) {
  double alpha = 0.0;

  double time_start = wall_time();

  for (int iterations = 0; iterations < NUM_ITERATIONS; iterations++) {
    alpha = 0.0;
    for (int i = 0; i < n; i++) {
      alpha += a[i] * b[i];
    }
  }
  *time_serial = wall_time() - time_start;
  return alpha;
}


double parallel_dot_product_reduction(double *a, double *b, int n, double* time_red) {
  double alpha_parallel = 0.0;

  double time_start = wall_time();

  for (int iterations = 0; iterations < NUM_ITERATIONS; iterations++) {
    alpha_parallel = 0.0;
    #pragma omp parallel for shared(a, b, n) reduction(+:alpha_parallel)
    for (int i = 0; i < n; i++) {
      alpha_parallel += a[i] * b[i];
    }
  }
  *time_red = wall_time() - time_start;
  return alpha_parallel;
}


double parallel_dot_product_critical(double *a, double *b, int n, double* time_critical){
    double alpha_parallel = 0.0;
    double time_start = wall_time();

    for (int iterations = 0; iterations < NUM_ITERATIONS; iterations++) {
        alpha_parallel = 0.0;

        #pragma omp parallel
        {
            double local_sum = 0.0;
            #pragma omp for nowait
            for (int i = 0; i < n; i++) {
                local_sum += a[i] * b[i];
            }

            #pragma omp critical
            {
                alpha_parallel += local_sum;
            }
        }
    }

    *time_critical = wall_time() - time_start;
    return alpha_parallel;
}
