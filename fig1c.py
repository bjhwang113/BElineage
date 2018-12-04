"""
Violinplot from a wide-form dataset
===================================

_thumb: .6, .45
"""
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
# sns.set(style="whitegrid")
# sns.axes_style("darkgrid")
sns.set_style("white", {'axes.grid' : False})
# f, ax = plt.subplots()
# Load the example dataset of brain network correlations
# df = sns.load_dataset("test2.txt")
pairdist = pd.read_csv("fig1b_input3.csv", sep=',')

# # Pull out a specific subset of networks
# used_networks = [1, 3, 4, 5, 6, 7, 8, 11, 12, 13, 16, 17]
# used_columns = (df.columns.get_level_values("network")
                          # .astype(int)
                          # .isin(used_networks))
# df = df.loc[:, used_columns]

# # Compute the correlation matrix and average over networks
# corr_df = df.corr().groupby(level="network").mean()
# corr_df.index = corr_df.index.astype(int)
# corr_df = corr_df.sort_index().T

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(11, 6))

# Draw a violinplot with a narrower bandwidth than the default
sns.violinplot(data=pairdist, palette="Set3", bw=.2, cut=1, linewidth=1)
# sns.violinplot(data=pairdist, palette="Set3")
# # Finalize the figure
ax.set(ylim=(0, 20), ylabel="Percent edited (%)", xlabel="")
# ax.set(xlim=(0, 11), ylabel="",
       # xlabel="Number of unique targetable sites")
sns.despine()

plt.show()
