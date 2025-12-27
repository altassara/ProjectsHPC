import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys
import re

input_filename = "hist_omp_strong_scaling.data"

threads_list = [1, 2, 4, 6, 8, 10, 12, 14]
times_list = []

with open(input_filename, 'r') as f:
    for line in f:
        if line.strip().startswith("Time:"):
            time_val = float(line.split()[1])
            times_list.append(time_val)

min_len = min(len(threads_list), len(times_list))

df = pd.DataFrame({
    "threads": threads_list[:min_len],
    "time": times_list[:min_len]
})

plt.figure(figsize=(9, 6))

plt.plot(df["threads"], df["time"], marker='o', linestyle='-',
         label="execution time", color='red', zorder=10)

plt.xscale("linear")
plt.yscale("log")

thread_ticks = sorted(df["threads"].unique())
plt.xticks(thread_ticks)
plt.xlim(left=1, right=max(thread_ticks) * 1.05)

plt.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.title("Strong Scaling Analysis", fontsize=14)
plt.xlabel("Number of Threads", fontsize=12)
plt.ylabel("Execution Time (seconds) - Log Scale", fontsize=12)
plt.legend(loc='best')

plt.tight_layout()
plt.savefig("strong_scaling.png", dpi=300, bbox_inches='tight')
plt.show()