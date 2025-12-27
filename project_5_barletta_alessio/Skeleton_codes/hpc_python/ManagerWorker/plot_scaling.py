import matplotlib.pyplot as plt

workers = []
times_50 = []
times_100 = []

with open('scaling_results.data', 'r') as f:
    for line in f:
        if line.startswith('#'): continue
        parts = line.split()
        if len(parts) < 3: continue
        
        w = int(parts[0])
        t = int(parts[1])
        s = float(parts[2])
        
        if w not in workers:
            workers.append(w)
            
        if t == 50:
            times_50.append(s)
        elif t == 100:
            times_100.append(s)

fig, axes = plt.subplots(1, 2, figsize=(12, 6))

ax_time = axes[0]
ax_time.plot(workers, times_50, marker='o', linestyle='-', color='green', label='50 Tasks')
ax_time.plot(workers, times_100, marker='s', linestyle='-', color='blue', label='100 Tasks')

ax_time.set_title('Execution Time', fontsize=10)
ax_time.set_ylabel('Time (s)')
ax_time.set_xlabel('Workers')
ax_time.grid(True, linestyle='--', linewidth=0.5)
ax_time.legend(loc='upper right', fontsize=8)

ax_speed = axes[1]

base_w = workers[0]
sp_50 = [(times_50[0] / t) * base_w for t in times_50]
sp_100 = [(times_100[0] / t) * base_w for t in times_100]

ax_speed.plot(workers, sp_50, marker='o', linestyle='-', color='green', label='50 Tasks Speedup')
ax_speed.plot(workers, sp_100, marker='s', linestyle='-', color='blue', label='100 Tasks Speedup')
ax_speed.plot(workers, workers, color='gray', linestyle='--', linewidth=1, label='Ideal')

ax_speed.set_title('Speedup', fontsize=10)
ax_speed.set_ylabel('Speedup')
ax_speed.set_xlabel('Workers')
ax_speed.grid(True, linestyle='--', linewidth=0.5)
ax_speed.legend(loc='upper left', fontsize=8)

plt.tight_layout()
plt.savefig("strong_scaling_combined.png", dpi=300)
plt.show()