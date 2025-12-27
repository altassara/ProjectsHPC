import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

df = pd.read_csv("execution_clean.data", sep="\s+", header=None,
                 names=["size", "threads", "serial", "reduction", "critical"])

sizes = sorted(df["size"].unique())
colors = {"serial": "black", "reduction": "blue", "critical": "red"}

ncols = 3
nrows = int(np.ceil(len(sizes) / ncols))

fig, axes = plt.subplots(nrows=nrows, ncols=ncols, figsize=(4 * ncols, 3.5 * nrows), sharey=True)

axes = axes.flatten()

yticks = [0.01, 0.1, 1, 10, 100]

for ax, s in zip(axes, sizes):
    subset = df[df["size"] == s]
    
    ax.plot(subset["threads"], subset["serial"], marker='o', color=colors["serial"], label="Serial")
    ax.plot(subset["threads"], subset["reduction"], marker='s', linestyle='--', color=colors["reduction"], label="Reduction")
    ax.plot(subset["threads"], subset["critical"], marker='^', linestyle='-.', color=colors["critical"], label="Critical")
    
    ax.set_xscale("linear")
    ax.set_yscale("log")
    ax.set_xticks(sorted(df["threads"].unique()))
    ax.set_xlim(left=1)
    ax.set_yticks(yticks)
    ax.set_yticklabels([str(y) for y in yticks]) 
    ax.grid(True, which="both", linestyle="--", linewidth=0.5)
    
    exponent = int(np.log10(s))
    ax.set_title(f"Size = $10^{{{exponent}}}$", fontsize=11)
    ax.legend(loc='best')

for i in range(len(sizes), len(axes)):
    axes[i].set_visible(False)

fig.text(0.5, 0.04, "Number of Threads", ha="center", fontsize=12)
fig.text(0.04, 0.5, "Execution Time (s)", va="center", rotation="vertical", fontsize=12)

plt.tight_layout(rect=[0.05, 0.05, 1, 1])
plt.savefig("strong_scaling_subplots.png", dpi=300, bbox_inches='tight')
plt.show()
