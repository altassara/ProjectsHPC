from mpi4py import MPI
import numpy as np

def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    my_rank = rank
    
    total_sum_pickle = comm.allreduce(my_rank, op=MPI.SUM)

    if rank == 0:
        print(f"[Pickle] Sum of ranks (0 to {size-1}): {total_sum_pickle}")


    send_buf = np.array([rank], dtype='i')
    recv_buf = np.array([0], dtype='i')
    comm.Allreduce(send_buf, recv_buf, op=MPI.SUM)

    if rank == 0:
        print(f"[Buffer] Sum of ranks (0 to {size-1}): {recv_buf[0]}")

if __name__ == "__main__":
    main()

