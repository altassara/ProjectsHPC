#include <stdlib.h>
#include <math.h>

const char* dgemm_desc = "Blocked dgemm.";

/* This routine performs a dgemm operation
 *
 *  C := C + A * B
 *
 * where A, B, and C are lda-by-lda matrices stored in column-major format.
 * On exit, A and B maintain their input values.
 */
#define min(a,b) (((a)<(b))?(a):(b))


void square_dgemm(int n, double* A, double* B, double* C) {
  
  const int blockSize = 64;

  double* block_A = (double*) malloc(blockSize * blockSize * sizeof(double));
  double* block_B = (double*) malloc(blockSize * blockSize * sizeof(double));
  double* block_C = (double*) malloc(blockSize * blockSize * sizeof(double));

  for (int ii = 0; ii < n; ii += blockSize) {
    int i_max = min(ii + blockSize, n);
    for (int jj = 0; jj < n; jj += blockSize) {
      int j_max = min(jj + blockSize, n);

      for (int j = jj; j < j_max; ++j)
        for (int i = ii; i < i_max; ++i)
            block_C[(i - ii) + (j - jj) * blockSize] = C[i + j * n];

      for (int kk = 0; kk < n; kk += blockSize) {
        int k_max = min(kk + blockSize, n);

        for (int k = kk; k < k_max; ++k)
          for (int i = ii; i < i_max; ++i)
              block_A[(i - ii) + (k - kk) * blockSize] = A[i + k * n];

        for (int j = jj; j < j_max; ++j)
          for (int k = kk; k < k_max; ++k)
              block_B[(k - kk) + (j - jj) * blockSize] = B[k + j * n];

        for (int j = 0; j < j_max - jj; ++j)
          for (int k = 0; k < k_max - kk; ++k)
            for (int i = 0; i < i_max - ii; ++i)
              block_C[i + j * blockSize] +=
                block_A[i + k * blockSize] * block_B[k + j * blockSize];
      }

      for (int j = jj; j < j_max; ++j)
          for (int i = ii; i < i_max; ++i)
              C[i + j * n] = block_C[(i - ii) + (j - jj) * blockSize];
    }
  }

  free(block_A);
  free(block_B);
  free(block_C);
}