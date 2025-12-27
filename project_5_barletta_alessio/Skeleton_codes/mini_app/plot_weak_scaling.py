import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter

counts = [1, 2, 4, 8, 16]
sizes  = [64, 91, 128, 181, 256]

times_threads = [0.064803, 0.103178, 0.14123, 0.230494, 0.413067]
times_mpi     = [0.0394589, 0.0456378, 0.0631239, 0.757311, 1.40078]

eff_threads = [times_threads[0] / t for t in times_threads]
eff_mpi     = [times_mpi[0] / t for t in times_mpi]

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))

ax1.plot(counts, eff_threads, marker='o', linestyle='-', color='green', label='Threads Efficiency')
ax1.plot(counts, eff_mpi, marker='s', linestyle='-', color='blue', label='MPI Efficiency')
ax1.axhline(1.0, color='gray', linestyle='--', linewidth=1, label='Ideal (100%)')

for t, s, e in zip(counts, sizes, eff_threads):
    ax1.text(t, e + 0.02, f'n={s}', ha='center', va='bottom', fontsize=8, color='green')

for t, s, e in zip(counts, sizes, eff_mpi):
    ax1.text(t, e - 0.03, f'n={s}', ha='center', va='top', fontsize=8, color='blue')

ax1.set_title('Weak Scaling Efficiency')
ax1.set_xlabel('Number of Threads / MPI Processes')
ax1.set_ylabel('Efficiency = t(1) / t(N)')
ax1.grid(True, which="both", linestyle='--', linewidth=0.5)
ax1.legend()
ax1.yaxis.set_major_formatter(ScalarFormatter())
ax1.yaxis.get_major_formatter().set_scientific(False)

ax2.plot(counts, times_threads, marker='o', linestyle='-', color='green', label='Threads Time')
ax2.plot(counts, times_mpi, marker='s', linestyle='-', color='blue', label='MPI Time')

for t, s, tm in zip(counts, sizes, times_threads):
    ax2.text(t, tm + 0.01, f'n={s}', ha='center', va='bottom', fontsize=8, color='green')

for t, s, tm in zip(counts, sizes, times_mpi):
    ax2.text(t, tm - 0.015, f'n={s}', ha='center', va='top', fontsize=8, color='blue')

ax2.set_title('Weak Scaling Execution Time')
ax2.set_xlabel('Number of Threads / MPI Processes')
ax2.set_ylabel('Time (s)')
ax2.grid(True, which="both", linestyle='--', linewidth=0.5)
ax2.legend()

plt.tight_layout()
plt.savefig("weak_scaling_combined_4nodes.png", dpi=300)
plt.show()