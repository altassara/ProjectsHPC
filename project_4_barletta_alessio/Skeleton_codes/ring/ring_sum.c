#include <mpi.h> // MPI
#include <stdio.h>

int main(int argc, char *argv[]) {

  // Initialize MPI, get size and rank
  int size, rank;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  // IMPLEMENT: Ring sum algorithm
  int sum = 0; // initialize sum
  int toSend = rank;

  int dest = (rank-1 + size) % size;
  int source = (rank+1) % size;

  for(int i=0; i<size; i++){
    int recv_val = 0;

    MPI_Sendrecv(&toSend, 1, MPI_INT, dest, 0,
                 &recv_val, 1, MPI_INT, source, 0,
                 MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    
    sum += recv_val;
    toSend = recv_val;

  }

  printf("Process %i: Sum = %i\n", rank, sum);

  // Finalize MPI
  MPI_Finalize();

  return 0;
}
