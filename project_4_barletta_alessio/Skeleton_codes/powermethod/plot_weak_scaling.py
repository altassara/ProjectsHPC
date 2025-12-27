import pandas as pd
import matplotlib.pyplot as plt

def process_data(filename):
    df = pd.read_csv(filename)
    
    t_base = df['time'].iloc[0]
    df['efficiency'] = t_base / df['time']
    
    return df

try:
    df_diff = process_data('data_weak_diffnodes.data')
    df_one = process_data('data_weak_onenode.data')
except FileNotFoundError as e:
    exit()

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

ax1.plot(df_diff['p'], df_diff['efficiency'], 'o-', label='Diff Nodes', linewidth=2)
ax1.plot(df_one['p'], df_one['efficiency'], 's--', label='One Node', linewidth=2)

ax1.set_title('Weak Scaling: Parallel Efficiency')
ax1.set_xlabel('Number of MPI Processes (p)')
ax1.set_ylabel('Efficiency (T(1)/T(p))')
ax1.set_ylim(0, 1.1) 
ax1.grid(True, linestyle='--', alpha=0.7)
ax1.legend()

ax1.set_xscale('log')
ax1.set_xticks(df_diff['p']) 
ax1.get_xaxis().set_major_formatter(plt.ScalarFormatter()) 

ax2.plot(df_diff['p'], df_diff['time'], 'o-', label='Diff Nodes', linewidth=2)
ax2.plot(df_one['p'], df_one['time'], 's--', label='One Node', linewidth=2)

ax2.set_title('Weak Scaling: Runtime')
ax2.set_xlabel('Number of MPI Processes (p)')
ax2.set_ylabel('Time (s)')
ax2.grid(True, linestyle='--', alpha=0.7)
ax2.legend()

ax2.set_xscale('log')
ax2.set_xticks(df_diff['p'])
ax2.get_xaxis().set_major_formatter(plt.ScalarFormatter())

plt.tight_layout()
plt.savefig('weak_scaling_plot.png', dpi=300)
plt.show()