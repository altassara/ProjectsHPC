#!/bin/bash
#SBATCH --job-name=manager_worker   # Nome del job
#SBATCH --nodes=4                   # Numero di nodi richiesti
#SBATCH --ntasks=8                  # Numero totale di task MPI (processi)
#SBATCH --ntasks-per-node=2         # Processi per ogni nodo
#SBATCH --time=00:05:00             # Tempo limite (hh:mm:ss)
#SBATCH --output=run_manWork_%j.err      # File dove salvare l'output (%j = job ID)
#SBATCH --error=run_manWork_%j.out        # File dove salvare gli errori

source $(conda info --base)/etc/profile.d/conda.sh

conda activate project5_env

mpiexec -n 8 python manager_worker.py 2000 2000 100