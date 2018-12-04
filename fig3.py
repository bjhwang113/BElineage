#!/usr/bin/python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

sns.set_style("whitegrid", {'axes.grid' : False})
sns.set(style="ticks")


df = pd.read_csv("fig_simulation_bias_yes.csv")
# df = pd.read_csv("fig_simulation_dropout_yes.csv")

# kws = dict(s=50, linewidth=.5, edgecolor="w")
 
# d = {"linestyles":['--', '--', '--']}

 # palette="Set1"
g = sns.FacetGrid(df, col="Editing_rate", hue="Target", hue_order=[800,1000])
 
ax = g.map(sns.pointplot, "Generation", "Accuracy")
# plt.plot(10,20, linestyle='dashed')


ax.set(ylim=(0,100))

# ax.set_xticks([6,7,8,9,10,11,12,13,14,15])
# ax.set_yticks([20,40,60,80,100])

# for ax in g.axes.flat:
	# ax.plot("Generation", "Accuracy", ls="--", data=df['Bias'])

# plt.plot("Generation", "Accuracy", linestyle='dashed', data=df)
plt.show()