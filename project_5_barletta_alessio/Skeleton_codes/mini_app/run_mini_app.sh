#!/bin/bash
#SBATCH --job-name=mini_app      # Job name    (default: sbatch)
#SBATCH --output=mini_app-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=mini_app-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --ntasks=16                # Number of tasks
#SBATCH --ntasks-per-node=16       # Number of tasks per node
#SBATCH --cpus-per-task=1         # Number of CPUs per task
#SBATCH --time=00:10:00           # Wall clock time limit

# Load some modules & list loaded modules
module load gcc openmpi
module list

# Compile
make clean
make

mpirun -np 8 ./main 1024 100 0.005 verbose