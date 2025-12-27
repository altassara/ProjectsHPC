import matplotlib.pyplot as plt

threads = [1, 2, 4, 8, 16]

times_64   = [0.0648923, 0.0433094, 0.0586185, 0.0717364, 0.124428]
times_128  = [0.355006, 0.213299, 0.130458, 0.141613, 0.176283]
times_256  = [2.37246, 1.26248, 0.68696, 0.451675, 0.414832]
times_512  = [17.7292, 8.93385, 4.53902, 2.55518, 1.61634]
times_1024 = [168.586, 87.2689, 45.3361, 25.8472, 19.7369]

sizes = [64, 128, 256, 512, 1024]
times = [times_64, times_128, times_256, times_512, times_1024]

fig, axes = plt.subplots(3, 2, figsize=(10, 10))
axes = axes.flatten()

for i, (n, t) in enumerate(zip(sizes, times)):
    ax = axes[i]
    ax.plot(threads, t, marker='o', linestyle='-', label=f'size: {n} x {n}')
    ax.set_title(f'size: {n} x {n}')
    ax.set_xlabel('Threads')
    ax.set_ylabel('Execution time (s)')
    ax.grid(True)
    ax.legend()

for j in range(len(sizes), len(axes)):
    fig.delaxes(axes[j])

plt.tight_layout()
plt.savefig("strong_scaling.png", dpi=300)
plt.show()
