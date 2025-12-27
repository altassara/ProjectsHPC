import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

try:
    df = pd.read_csv("execution.data", sep="\s+", header=None,
                     names=["threads", "time"])
except FileNotFoundError:
    print("Errore: 'execution.data' non è stato trovato.")
    exit()
except pd.errors.EmptyDataError:
    print("Errore: 'execution.data' è vuoto.")
    exit()

try:
    serial_time = df[df['threads'] == 1]['time'].iloc[0]
except IndexError:
    print("Errore: Impossibile trovare il tempo per 1 thread nel file. Assicurati che esista.")
    exit()

df["speedup"] = serial_time / df["time"]

fig, ax = plt.subplots(figsize=(8, 6))

threads = sorted(df["threads"].unique())

ax.plot(df["threads"], df["speedup"], marker='o', color='blue', 
        label="Measured Speedup")

min_t = min(threads)
max_t = max(threads)

ax.set_xticks(threads) 
ax.get_xaxis().set_major_formatter(plt.ScalarFormatter()) 
ax.set_xlabel("Number of Threads", fontsize=12)

ax.set_ylim(0, max_t + 1) 
ax.set_ylabel("Speedup (T_1_thread / T_n_threads)", fontsize=12)

ax.set_title("Speedup vs. Number of Threads", fontsize=14)
ax.legend(loc='best')
ax.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.tight_layout()
plt.savefig("parallel_speedup.png", dpi=300, bbox_inches='tight')
plt.show()

