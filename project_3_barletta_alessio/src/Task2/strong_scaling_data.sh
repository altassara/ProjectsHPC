for num_threads in 1 2 4 8 16
do
    export OMP_NUM_THREADS=$num_threads
    for n in 64 128 256 512 1024
    do
        ./main $n 100 0.005 >> "strong_scaling_data_${num_threads}_threads.txt"
    done    
done