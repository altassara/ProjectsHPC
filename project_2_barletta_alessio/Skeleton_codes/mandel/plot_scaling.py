import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys

input_filename = "execution.data"

df = pd.read_csv(input_filename, sep="\s+", header=None,
                     names=["threads", "time"])

df = df.sort_values(by="threads").reset_index(drop=True)

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