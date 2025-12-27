#!/bin/bash
#SBATCH --job-name=test_val      # Job name    (default: sbatch)
#SBATCH --output=test_val-%j.out # Output file (default: slurm-%j.out)
#SBATCH --error=test_val-%j.err  # Error file  (default: slurm-%j.out)
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --ntasks=1                # Number of tasks
#SBATCH --ntasks-per-node=1       # Number of tasks per node
#SBATCH --cpus-per-task=1         # Number of CPUs per task
#SBATCH --time=00:10:00           # Wall clock time limit


# This script tests if the code runs correctly. The norm of the solution must be the same!

# TODO: Nothing, just run the script.

# Run the Python solver
python3 ../poisson_py.py -nx 128 -ny 32

# Visualize the results for dense and sparse solvers
python3 ../draw.py solution_dn_dir
python3 ../draw.py solution_sp_dir

# Run the PETSc solver
mpirun -np 1 ../poisson_petsc -nx 128 -ny 32

# Visualize the PETSc solution
python3 ../draw.py solution_petsc
