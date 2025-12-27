import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter

def process_strong_scaling(filename):
    df = pd.read_csv(filename)
    
    t_base = df['time'].iloc[0]
    p_base = df['p'].iloc[0]
    
    # Speedup = T(1) / T(p)
    df['speedup'] = t_base / df['time']
    
    # Efficiency = Speedup / p
    scaling_factor = df['p'] / p_base
    df['efficiency'] = df['speedup'] / scaling_factor
    
    return df

try:
    df_diff = process_strong_scaling('data_strong_diffnodes.data')
    df_one = process_strong_scaling('data_strong_onenode.data')
except FileNotFoundError as e:
    exit()

fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(18, 6))

ax1.plot(df_diff['p'], df_diff['speedup'], 'o-', label='Diff Nodes', linewidth=2)
ax1.plot(df_one['p'], df_one['speedup'], 's--', label='One Node', linewidth=2)

ideal_x = [df_diff['p'].min(), df_diff['p'].max()]
ideal_y = [df_diff['p'].min(), df_diff['p'].max()]
ax1.plot(ideal_x, ideal_y, 'k:', label='Ideal', alpha=0.6)

ax1.set_title('Strong Scaling: Speedup')
ax1.set_xlabel('Processes (p)')
ax1.set_ylabel('Speedup')
ax1.set_xscale('log')
ax1.set_yscale('log')
ax1.legend()
ax1.grid(True, which="both", ls="--", alpha=0.5)

for axis in [ax1.xaxis, ax1.yaxis]:
    axis.set_major_formatter(ScalarFormatter())
    axis.set_minor_formatter(ScalarFormatter())

ax2.plot(df_diff['p'], df_diff['efficiency'], 'o-', label='Diff Nodes', linewidth=2)
ax2.plot(df_one['p'], df_one['efficiency'], 's--', label='One Node', linewidth=2)

ax2.set_title('Strong Scaling: Efficiency')
ax2.set_xlabel('Processes (p)')
ax2.set_ylabel('Efficiency')
ax2.set_ylim(0, 1.2)
ax2.set_xscale('log')
ax2.legend()
ax2.grid(True, which="both", ls="--", alpha=0.5)
ax2.xaxis.set_major_formatter(ScalarFormatter())

ax3.plot(df_diff['p'], df_diff['time'], 'o-', label='Diff Nodes', linewidth=2)
ax3.plot(df_one['p'], df_one['time'], 's--', label='One Node', linewidth=2)

ax3.set_title('Strong Scaling: Runtime')
ax3.set_xlabel('Processes (p)')
ax3.set_ylabel('Time (s)')
ax3.set_xscale('log')
ax3.set_yscale('log')
ax3.legend()
ax3.grid(True, which="both", ls="--", alpha=0.5)

ax3.xaxis.set_major_formatter(ScalarFormatter())
ax3.yaxis.set_major_formatter(ScalarFormatter()) 
ax3.yaxis.set_minor_formatter(ScalarFormatter()) 

plt.tight_layout()
plt.show()