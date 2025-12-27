import matplotlib.pyplot as plt

threads = [1, 2, 4, 8, 16]
sizes   = [64, 128, 256, 512, 1024]

times_th_64   = [0.0648923, 0.0433094, 0.0586185, 0.0717364, 0.124428]
times_th_128  = [0.355006, 0.213299, 0.130458, 0.141613, 0.176283]
times_th_256  = [2.37246, 1.26248, 0.68696, 0.451675, 0.414832]
times_th_512  = [17.7292, 8.93385, 4.53902, 2.55518, 1.61634]
times_th_1024 = [168.586, 87.2689, 45.3361, 25.8472, 19.7369]

times_mpi_64   = [0.0422238, 0.0217105, 0.0129691, 0.300071, 0.519655]
times_mpi_128  = [0.23637, 0.118917, 0.0622023, 0.518514, 0.7024]
times_mpi_256  = [1.64153, 0.838004, 0.436916, 0.918334, 1.34864]
times_mpi_512  = [12.1727, 6.64996,  3.20195, 3.72111, 3.19281]
times_mpi_1024 = [131.54, 70.1224, 44.421, 28.3747, 11.8952]

times_th_all  = [times_th_64, times_th_128, times_th_256, times_th_512, times_th_1024]
times_mpi_all = [times_mpi_64, times_mpi_128, times_mpi_256, times_mpi_512, times_mpi_1024]

fig, axes = plt.subplots(5, 2, figsize=(12, 18))

for i, (n, t_th, t_mpi) in enumerate(zip(sizes, times_th_all, times_mpi_all)):
    ax_time = axes[i, 0]
    ax_time.plot(threads, t_th, marker='o', linestyle='-', color='green', label='Threads Time')
    ax_time.plot(threads, t_mpi, marker='s', linestyle='-', color='blue', label='MPI Time')
    
    ax_time.set_title(f'Execution Time - Size {n}x{n}', fontsize=10)
    ax_time.set_ylabel('Time (s)')
    ax_time.grid(True, linestyle='--', linewidth=0.5)
    if i == 0: ax_time.legend(loc='upper right', fontsize=8) 

    ax_speed = axes[i, 1]
    
    sp_th  = [t_th[0] / t for t in t_th]
    sp_mpi = [t_mpi[0] / t for t in t_mpi]

    ax_speed.plot(threads, sp_th, marker='o', linestyle='-', color='green', label='Threads Speedup')
    ax_speed.plot(threads, sp_mpi, marker='s', linestyle='-', color='blue', label='MPI Speedup')
    ax_speed.plot(threads, threads, color='gray', linestyle='--', linewidth=1, label='Ideal')

    ax_speed.set_title(f'Speedup - Size {n}x{n}', fontsize=10)
    ax_speed.set_ylabel('Speedup')
    ax_speed.grid(True, linestyle='--', linewidth=0.5)
    if i == 0: ax_speed.legend(loc='upper left', fontsize=8)

    if i == 4:
        ax_time.set_xlabel('Threads / Processes')
        ax_speed.set_xlabel('Threads / Processes')

plt.tight_layout()
plt.savefig("strong_scaling_combined_4nodes.png", dpi=300)
plt.show()