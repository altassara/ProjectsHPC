#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <omp.h>

int main(int argc, char *argv[]) {
  long int N = 10000000000; // <<< carefull! This larger than regular int (its a long int)
  double dx = 1./double(N);
  double sum=0;
  double pi =0;
  double time=0;


  time = omp_get_wtime();
  
  for(long int i=0; i<N; i++){
      double x = (i + 0.5) * dx;
      sum += 4.0 / (1.0 + x*x);
  }
  pi = sum * dx;
  time = omp_get_wtime() - time;
  printf("--- Serial ---\n");
  printf("pi=%e, N=%ld, time_srl=%e secs\n", pi, N, time);
  printf("\n--- SpeedUp ---\n");


  for(int t : {1, 2, 4, 8}){
    omp_set_num_threads(t);

    time = omp_get_wtime();
    sum = 0.;
    #pragma omp parallel for shared(dx) reduction(+:sum)
    for(long int i=0; i<N; i++){
        double x = (i + 0.5) * dx;
        sum += 4.0 / (1.0 + x*x);
    }
    pi = sum * dx;

    time = omp_get_wtime() - time;
    printf("n_threads %d speed %f\n", t, time);
  }

  return 0;
}
