import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter

threads = [1, 2, 4, 8, 16]
sizes   = [64, 91, 128, 181, 256]

times = [0.064803, 0.103178, 0.14123, 0.230494, 0.413067]

t1 = times[0]
efficiency = [t1 / t for t in times]

plt.figure(figsize=(8, 6))
plt.plot(threads, efficiency, marker='o', linestyle='-', color='green', label='Efficency')

for t, s, e in zip(threads, sizes, efficiency):
    plt.text(t, e * 1.003, f'n={s}', ha='center', fontsize=9)

plt.axhline(1.0, color='gray', linestyle='--', linewidth=1, label='Ideal (100%)')

plt.title('Weak Scaling Efficiency ')
plt.xlabel('Threads number')
plt.ylabel('Efficency = t(1) / t(N)')

plt.gca().yaxis.set_major_formatter(ScalarFormatter())
plt.gca().yaxis.get_major_formatter().set_scientific(False)

plt.grid(True, which="both", linestyle='--', linewidth=0.5)
plt.legend()
plt.tight_layout()
plt.savefig("weak_scaling.png", dpi=300)
plt.show()
