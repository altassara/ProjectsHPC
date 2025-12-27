#!/bin/bash
#SBATCH --job-name=recur-omp      # Job name
#SBATCH --output=recur-omp-%j.out # Output file
#SBATCH --error=recur-omp-%j.err  # Error file
#SBATCH --ntasks=1                   # Number of tasks
#SBATCH --cpus-per-task=20           # Number of CPUs per task
#SBATCH --mem-per-cpu=1024           # Memory per CPU
#SBATCH --time=00:05:00              # Wall clock time limit

# Load some modules & list loaded modules
module load gcc
module list

# Compile
make clean
make

# OpenMP settings
export OMP_PROC_BIND=true

# Strong scaling
echo "=== parallel execution 20 threads ========================"

OMP_NUM_THREADS=20
export OMP_NUM_THREADS
./recur_omp

