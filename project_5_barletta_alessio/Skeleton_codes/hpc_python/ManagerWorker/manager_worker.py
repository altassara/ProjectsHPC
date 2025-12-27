from mandelbrot_task import *
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
from mpi4py import MPI # MPI_Init and MPI_Finalize automatically called
import numpy as np
import sys
import time

# some parameters
MANAGER = 0       # rank of manager
TAG_TASK      = 1 # task       message tag
TAG_TASK_DONE = 2 # tasks done message tag
TAG_DONE      = 3 # done       message tag

def manager(comm, tasks):
    """
    The manager.

    Parameters
    ----------
    comm : mpi4py.MPI communicator
        MPI communicator
    tasks : list of objects with a do_task() method perfroming the task
        List of tasks to accomplish

    Returns
    -------
    Output the final mandelbrot set.
    """

    status = MPI.Status()
    ntasks = len(tasks)
    nworkers = comm.Get_size() - 1

    global TasksDoneByWorker
    TasksDoneByWorker = np.zeros(comm.Get_size(), dtype=int)

    task_index = 0
    for iworker in range(1, min(nworkers, ntasks) + 1):
        comm.send(tasks[task_index], dest=iworker, tag=TAG_TASK)
        task_index += 1

    completed_tasks = []
    while task_index < ntasks:
        task = comm.recv(source=MPI.ANY_SOURCE, tag=TAG_TASK_DONE,
                         status=status)
        worker_rank = status.Get_source()
        TasksDoneByWorker[worker_rank] += 1
        completed_tasks.append(task)
        comm.send(tasks[task_index], dest=worker_rank, tag=TAG_TASK)
        task_index += 1

    for iworker in range(1, min(nworkers, ntasks) + 1):
        task = comm.recv(source=MPI.ANY_SOURCE, tag=TAG_TASK_DONE,
                         status=status)
        worker_rank = status.Get_source()
        TasksDoneByWorker[worker_rank] += 1
        completed_tasks.append(task)

    for iworker in range(1, nworkers + 1):
        comm.send(None, dest=iworker, tag=TAG_DONE)


    return completed_tasks

def worker(comm):
    """
    The worker.

    Parameters
    ----------
    comm : mpi4py.MPI communicator
        MPI communicator
    """

    status = MPI.Status()

    while True:
        task = comm.recv(source=MANAGER, tag=MPI.ANY_TAG, status=status)
        tag = status.Get_tag()

        if tag == TAG_DONE:
            break

        elif tag == TAG_TASK:
            task.do_work()
            comm.send(task, dest=MANAGER, tag=TAG_TASK_DONE)

def readcmdline(rank):
    """
    Read command line arguments

    Parameters
    ----------
    rank : int
        Rank of calling MPI process

    Returns
    -------
    nx : int
        number of gridpoints in x-direction
    ny : int
        number of gridpoints in y-direction
    ntasks : int
        number of tasks
    """
    # report usage
    if len(sys.argv) != 4:
        if rank == MANAGER:
            print("Usage: manager_worker nx ny ntasks")
            print("  nx     number of gridpoints in x-direction")
            print("  ny     number of gridpoints in y-direction")
            print("  ntasks number of tasks")
        sys.exit()

    # read nx, ny, ntasks
    nx = int(sys.argv[1])
    if nx < 1:
        sys.exit("nx must be a positive integer")
    ny = int(sys.argv[2])
    if ny < 1:
        sys.exit("ny must be a positive integer")
    ntasks = int(sys.argv[3])
    if ntasks < 1:
        sys.exit("ntasks must be a positive integer")

    return nx, ny, ntasks


if __name__ == "__main__":

    # get COMMON WORLD communicator, size & rank
    comm    = MPI.COMM_WORLD
    size    = comm.Get_size()
    my_rank = comm.Get_rank()

    # report on MPI environment
    if my_rank == MANAGER:
        print(f"MPI initialized with {size:5d} processes")

    # read command line arguments
    nx, ny, ntasks = readcmdline(my_rank)

    # start timer
    timespent = - time.perf_counter()

    # trying out ... YOUR MANAGER-WORKER IMPLEMENTATION HERE ...
    x_min = -2.
    x_max  = +1.
    y_min  = -1.5
    y_max  = +1.5

    if my_rank == MANAGER:
        M = mandelbrot(x_min, x_max, nx, y_min, y_max, ny, ntasks)
        tasks = M.get_tasks()
        completed_tasks = manager(comm, tasks)
        m = M.combine_tasks(completed_tasks)
        plt.imshow(m.T, cmap="gray", extent=[x_min, x_max, y_min, y_max])
        plt.savefig("mandelbrot.png")
    else:
        worker(comm)

    # stop timer
    timespent += time.perf_counter()

    # inform that done
    if my_rank == MANAGER:
        print(f"Run took {timespent:f} seconds")
        for i in range(size):
            if i == MANAGER:
                continue
            print(f"Process {i:5d} has done {TasksDoneByWorker[i]:10d} tasks")
        print("Done.")
