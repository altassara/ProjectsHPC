threads=(1 2 4 8 16)
sizes=(64 91 128 181 256)

for i in "${!threads[@]}"
do
    num_threads=${threads[$i]}
    n=${sizes[$i]}
    export OMP_NUM_THREADS=$num_threads
    echo "Running with $num_threads threads and n=$n"
    ./main $n 100 0.005 >> "weak_scaling_data_${num_threads}_threads.txt"
done
