import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

df = pd.read_csv("execution_clean.data", sep="\s+", header=None,
                 names=["size", "threads", "serial", "reduction", "critical"])

sizes = sorted(df["size"].unique())
colors = {"reduction": "blue", "critical": "red"}

df["eff_reduction"] = df["serial"] / (df["reduction"] * df["threads"])
df["eff_critical"]  = df["serial"] / (df["critical"]  * df["threads"])

ncols = 3
nrows = int(np.ceil(len(sizes) / ncols))

fig, axes = plt.subplots(nrows=nrows, ncols=ncols, figsize=(4 * ncols, 3.5 * nrows), sharey=True)

axes = axes.flatten()

if len(sizes) == 1:
    axes = [axes]

for ax, s in zip(axes, sizes):
    subset = df[df["size"] == s]
    
    ax.plot(subset["threads"], subset["eff_reduction"], marker='o', color=colors["reduction"], label="Reduction")
    ax.plot(subset["threads"], subset["eff_critical"], marker='^', color=colors["critical"], linestyle='--', label="Critical")
    
    ax.set_xscale("log", base=2)
    ax.set_xticks(sorted(df["threads"].unique()))
    ax.get_xaxis().set_major_formatter(plt.ScalarFormatter())
    
    ax.set_ylim(0, 1.1)
    ax.grid(True, which="both", linestyle="--", linewidth=0.5)
    
    exponent = int(np.log10(s))
    ax.set_title(f"Size = $10^{{{exponent}}}$", fontsize=12)
    ax.legend(loc='best')

for i in range(len(sizes), len(axes)):
    axes[i].set_visible(False)

fig.text(0.5, 0.04, "Number of Threads (log scale)", ha="center", fontsize=12)
fig.text(0.04, 0.5, "Parallel Efficiency", va="center", rotation="vertical", fontsize=12)

plt.tight_layout(rect=[0.05, 0.05, 1, 1])
plt.savefig("parallel_efficiency_subplots.png", dpi=300, bbox_inches='tight')
plt.show()
