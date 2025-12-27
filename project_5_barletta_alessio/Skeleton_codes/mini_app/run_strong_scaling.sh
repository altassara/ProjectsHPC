#!/bin/bash
#SBATCH --job-name=mini_app_strong_scaling      # Job name    (default: sbatch)
#SBATCH --output=mini_app_strong_scaling-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=mini_app_strong_scaling-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --nodes=4                 # Number of nodes
#SBATCH --ntasks=16                # Number of tasks
#SBATCH --ntasks-per-node=4       # Number of tasks per node
#SBATCH --cpus-per-task=1         # Number of CPUs per task
#SBATCH --time=00:45:00           # Wall clock time limit

# Load some modules & list loaded modules
module load gcc openmpi
module list

# Compile
make clean
make

for num_proc in 1 2 4 8 16
do
    for n in 64 128 256 512 1024
    do
        mpirun -np $num_proc ./main $n 100 0.005 >> "strong_scaling_data_${num_proc}_processes.txt"
    done    
done