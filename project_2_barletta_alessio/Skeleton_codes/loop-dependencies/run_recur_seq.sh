#!/bin/bash
#SBATCH --job-name=recur-seq     # Job name
#SBATCH --output=recur-seq-%j.out # Output file
#SBATCH --error=recur-seq-%j.err  # Error file
#SBATCH --ntasks=1               # Number of tasks
#SBATCH --cpus-per-task=4        # Number of CPUs per task
#SBATCH --mem-per-cpu=1024       # Memory per CPU
#SBATCH --time=00:05:00          # Wall clock time limit

# Load some modules & list loaded modules
module load gcc
module list

# Compile
make clean
make

# Run
./recur_seq
