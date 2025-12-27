#!/bin/bash
#SBATCH --job-name=mandelbrot_scaling
#SBATCH --nodes=9
#SBATCH --ntasks=17
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:20:00
#SBATCH --output=scaling_%j.out
#SBATCH --error=scaling_%j.err

source $(conda info --base)/etc/profile.d/conda.sh
conda activate project5_env

DATA_FILE="scaling_results.data"
echo "# Workers Tasks Time(s)" > $DATA_FILE

for WORKERS in 2 4 8 16; do
    NTOT=$((WORKERS + 1))
    
    for TASKS in 50 100; do
        OUTPUT=$(mpiexec -n $NTOT python manager_worker.py 4001 4001 $TASKS)
        TIME=$(echo "$OUTPUT" | grep "Run took" | awk '{print $3}')
        echo "$WORKERS $TASKS $TIME" >> $DATA_FILE
    done
done