#!/bin/bash
#SBATCH --job-name=powermethod      # Job name    (default: sbatch)
#SBATCH --output=powermethod-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=powermethod-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --nodes=4                 # Number of nodes
#SBATCH --ntasks=16                # Number of tasks
#SBATCH --ntasks-per-node=4       # Number of tasks per node
#SBATCH --cpus-per-task=1         # Number of CPUs per task
#SBATCH --time=00:10:00           # Wall clock time limit

# Load some modules & list loaded modules
module load gcc openmpi
module list

# Compile
make clean
make

# Run the program with 16 MPI processes on 4 different nodes
mpirun ./powermethod_rows 1 1000 100 1e-6
mpirun ./powermethod_rows 2 1000 100 1e-6
mpirun ./powermethod_rows 3 1000 100 1e-6
mpirun ./powermethod_rows 4 1000 100 1e-6