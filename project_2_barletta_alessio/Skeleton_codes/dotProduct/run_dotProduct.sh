#!/bin/bash
#SBATCH --job-name=dot-product      # Job name    (default: sbatch)
#SBATCH --output=dot-product-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=dot-product-%j.err  # Error file  (default: slurm-%j.out)
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
srun ./dotProduct | tee execution.data

# Clean the data file (remove extra text)
awk '{print $2, $4, $7, $10, $13}' execution.data > execution_clean.data


# Plot the results
# python3 plot_dotProduct.py #not working on the cluster, missing dependencies
