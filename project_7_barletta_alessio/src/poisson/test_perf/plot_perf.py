import matplotlib.pyplot as plt

grid_sizes = [8, 16, 32, 64, 128, 256, 512]

time_petsc = [0.000042, 0.000091, 0.000482, 0.003285, 0.025969, 0.207658, 1.949982]
time_sp_dir = [0.002183, 0.000710, 0.002927, 0.014577, 0.081674, 0.542588, 4.695807]
time_sp_cg = [0.000485, 0.001104, 0.002434, 0.008295, 0.043647, 0.307943, 3.227063]

grid_sizes_dense = [8, 16, 32, 64, 128]
time_dn_dir = [0.003733, 0.001357, 0.042544, 1.822412, 99.442248]

plt.figure(figsize=(10, 6))

plt.loglog(grid_sizes, time_sp_dir, marker='o', linestyle='-', label='Sparse Direct (Python)')
plt.loglog(grid_sizes_dense, time_dn_dir, marker='s', linestyle='--', label='Dense Direct (Python)')
plt.loglog(grid_sizes, time_sp_cg, marker='^', linestyle='-.', label='Conjugate Gradient (Python)')
plt.loglog(grid_sizes, time_petsc, marker='x', linestyle=':', label='PETSc (C)')

plt.xticks(grid_sizes, labels=[str(x) for x in grid_sizes])
plt.minorticks_off()

plt.xlabel('Mesh Grid Size (N)')
plt.ylabel('Runtime (seconds)')
plt.title('Solver Runtime vs Grid Size')
plt.legend()
plt.grid(True, which="major", ls="-", alpha=0.5)

plt.savefig('runtime_loglog_plot.png')