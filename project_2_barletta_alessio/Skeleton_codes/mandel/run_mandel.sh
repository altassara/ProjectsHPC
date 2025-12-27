#!/bin/bash
#SBATCH --job-name=mandel-seq      # Job name    (default: sbatch)
#SBATCH --output=mandel-seq-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=mandel-seq-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --ntasks=1                # Number of tasks
#SBATCH --cpus-per-task=8         # Number of CPUs per task
#SBATCH --mem-per-cpu=1024        # Memory per CPU
#SBATCH --time=00:35:00           # Wall clock time limit

# Load some modules & list loaded modules
module load gcc
module list

# Compile
make clean
make

# Run the program
srun ./mandel_seq