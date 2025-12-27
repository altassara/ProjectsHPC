#!/bin/bash
#SBATCH --job-name=test_val      # Job name    (default: sbatch)
#SBATCH --output=test_val-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=test_val-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --ntasks=16                # Number of tasks
#SBATCH --ntasks-per-node=16       # Number of tasks per node
#SBATCH --cpus-per-task=1         # Number of CPUs per task
#SBATCH --time=00:10:00           # Wall clock time limit

# Strong Scaling for performance of PETSc with " -ksp_type cg" :

# TODO: Nothing, just run the script.

LOG_FILE=log.log
> $LOG_FILE

SIZE=1024 
for NUMP_PROC in 1 2 4 8 16; do
    echo "####################################################" | tee -a $LOG_FILE
    echo "Running PETSc solver with $NUMP_PROC processes for grid size ${SIZE}x${SIZE}" | tee -a $LOG_FILE
    echo "####################################################" | tee -a $LOG_FILE
    mpirun -np $NUMP_PROC ../poisson_petsc -ksp_type cg -nx $SIZE -ny $SIZE -log_view :performance_log_$NUMP_PROC.log 2>&1 | tee -a $LOG_FILE
done
