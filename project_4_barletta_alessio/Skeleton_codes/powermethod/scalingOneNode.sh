#!/bin/bash
#SBATCH --job-name=scale_one
#SBATCH --output=scale_one-%j.out
#SBATCH --error=scale_one-%j.err
#SBATCH --nodes=1                  
#SBATCH --ntasks=20                
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

module load gcc openmpi
make clean
make

F_STRONG="data_strong_onenode.data"
F_WEAK="data_weak_onenode.data"

echo "p,n,iter,theta,time" | tee $F_STRONG $F_WEAK > /dev/null

ITERS=300
TOL=-1e-6
BASE_N=10000
PROCS=(1 2 4 8 16 20)
WEAK_NS=(10000 14142 20000 28284 40000 44721)

echo "--- ONE NODE ANALYSIS ---"

for i in "${!PROCS[@]}"; do
    p=${PROCS[$i]}
    n_weak=${WEAK_NS[$i]}


    mpirun -np $p ./powermethod_rows 3 $BASE_N $ITERS $TOL \
        | grep "###" | sed 's/###//g' | sed 's/ //g' >> $F_STRONG

    mpirun -np $p ./powermethod_rows 3 $n_weak $ITERS $TOL \
        | grep "###" | sed 's/###//g' | sed 's/ //g' >> $F_WEAK
        
    echo "Done P=$p on Single Node"
done