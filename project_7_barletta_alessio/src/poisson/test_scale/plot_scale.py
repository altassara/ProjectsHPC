import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter

num_procs = [1, 2, 4, 8, 16]
runtimes = [18.680469, 10.798655, 5.303492, 3.544423, 1.815513]

ideal_runtimes = [runtimes[0] / p for p in num_procs]

plt.figure(figsize=(10, 7))

plt.loglog(num_procs, runtimes, marker='o', markersize=8, linestyle='-', linewidth=2, label='PETSc CG Solver (1024x1024)')
plt.loglog(num_procs, ideal_runtimes, linestyle='--', color='gray', alpha=0.6, label='Ideal Strong Scaling')

plt.xlabel('Number of MPI Processes')
plt.xticks(num_procs, labels=[str(x) for x in num_procs])
plt.minorticks_off()

plt.ylabel('Runtime (seconds)')

y_ticks = [2, 3, 4, 5, 8, 10, 15, 20]
plt.yticks(y_ticks, labels=[str(y) for y in y_ticks])

plt.gca().yaxis.set_major_formatter(ScalarFormatter())

plt.title('Parallel Scalability: Runtime vs Processes (Strong Scaling)')
plt.legend()
plt.grid(True, which="major", ls="-", alpha=0.6)
plt.grid(True, which="minor", ls=":", alpha=0.3)

plt.savefig('scalability_loglog_plot.png')