#!/bin/bash
#SBATCH --job-name=mini_app_weak_scaling      # Job name    (default: sbatch)
#SBATCH --output=mini_app_weak_scaling-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=mini_app_weak_scaling-%j.err  # Error file  (default: slurm-%j.out)
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

proc=(1 2 4 8 16)
sizes=(64 91 128 181 256)

for i in "${!proc[@]}"
do
    num_proc=${proc[$i]}
    n=${sizes[$i]}
    echo "Running with $num_proc processes and n=$n"
    mpirun -np $num_proc ./main $n 100 0.005 >> "weak_scaling_data_${num_proc}_processes.txt"
done