from mpi4py import MPI
import numpy as np
import sys


def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    dims = MPI.Compute_dims(size, 2)

    cart_comm = comm.Create_cart(dims, periods=[True, True])

    my_rank = cart_comm.Get_rank()
    my_coords = cart_comm.Get_coords(my_rank)
    neigh_north, neigh_south = cart_comm.Shift(0, 1)
    neigh_west, neigh_east = cart_comm.Shift(1, 1)

    print(f"[Proc {my_rank} @ {my_coords}] Neighbours -> N:{neigh_north}, S:{neigh_south}, W:{neigh_west}, E:{neigh_east}")

    val_south = cart_comm.sendrecv(sendobj=my_rank, dest=neigh_north, source=neigh_south)
    val_north = cart_comm.sendrecv(sendobj=my_rank, dest=neigh_south, source=neigh_north)
    val_east = cart_comm.sendrecv(sendobj=my_rank, dest=neigh_west, source=neigh_east)
    val_west = cart_comm.sendrecv(sendobj=my_rank, dest=neigh_east, source=neigh_west)

    for i in range(size):
        if rank == i:
            print(f"   -> [Proc {my_rank}] Received values from: "
                    f"N={val_north}, S={val_south}, W={val_west}, E={val_east}")
            sys.stdout.flush()
        cart_comm.Barrier()
        
    cart_comm.Barrier()

    if(rank == 0):
        print("----------------------------------------------------------------------")
        print("now using buffer method")

    sendbuf_north = np.array([my_rank], dtype='i')
    recvbuf_south = np.empty(1, dtype='i')
    cart_comm.Sendrecv(sendbuf=sendbuf_north, dest=neigh_north,
                       recvbuf=recvbuf_south, source=neigh_south) 
    
    sendbuf_south = np.array([my_rank], dtype='i')
    recvbuf_north = np.empty(1, dtype='i')
    cart_comm.Sendrecv(sendbuf=sendbuf_south, dest=neigh_south,
                       recvbuf=recvbuf_north, source=neigh_north)
    
    sendbuf_east = np.array([my_rank], dtype='i')
    recvbuf_west = np.empty(1, dtype='i')
    cart_comm.Sendrecv(sendbuf=sendbuf_east, dest=neigh_east,
                       recvbuf=recvbuf_west, source=neigh_west)
    
    sendbuf_west = np.array([my_rank], dtype='i')
    recvbuf_east = np.empty(1, dtype='i')
    cart_comm.Sendrecv(sendbuf=sendbuf_west, dest=neigh_west,
                       recvbuf=recvbuf_east, source=neigh_east)

    for i in range(size):
        if rank == i:
            print(f"   -> [Proc {my_rank}] Received values from: "
                  f"N={recvbuf_north[0]}, S={recvbuf_south[0]}, W={recvbuf_west[0]}, E={recvbuf_east[0]}")
            sys.stdout.flush()
        cart_comm.Barrier()

    cart_comm.Barrier()


if __name__ == "__main__":
    main()