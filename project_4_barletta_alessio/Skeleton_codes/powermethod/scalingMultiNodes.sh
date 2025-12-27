#!/bin/bash
#SBATCH --job-name=scale_diff
#SBATCH --output=scale_diff-%j.out
#SBATCH --error=scale_diff-%j.err
#SBATCH --nodes=16                 
#SBATCH --ntasks=32                
#SBATCH --ntasks-per-node=2        
#SBATCH --time=00:15:00

module load gcc openmpi
make clean
make

F_STRONG="data_strong_diffnodes.data"
F_WEAK="data_weak_diffnodes.data"

echo "p,n,iter,theta,time" | tee $F_STRONG $F_WEAK > /dev/null

ITERS=300
TOL=-1e-6
BASE_N=10000
PROCS=(1 2 4 8 16 20)
WEAK_NS=(10000 14142 20000 28284 40000 44721)

echo "--- DIFFERENT NODES ANALYSIS ---"

for i in "${!PROCS[@]}"; do
    p=${PROCS[$i]}
    n_weak=${WEAK_NS[$i]}

    
    mpirun -np $p --map-by node ./powermethod_rows 3 $BASE_N $ITERS $TOL \
        | grep "###" | sed 's/###//g' | sed 's/ //g' >> $F_STRONG

    mpirun -np $p --map-by node ./powermethod_rows 3 $n_weak $ITERS $TOL \
        | grep "###" | sed 's/###//g' | sed 's/ //g' >> $F_WEAK
        
    echo "Done P=$p on Different Nodes"
done