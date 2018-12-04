#!/usr/bin/python

import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

sns.set(style="ticks")

spacer_cfreq = pd.read_csv("fig2a_input_new2.txt", sep='\t', names = ['sample','freq', 'design'] )

# print pairdist
# exit(1)

ax = sns.boxplot(x="sample", y="freq", hue="design", data=spacer_cfreq, palette="PRGn")
ax.set_ylim([0,50])
plt.show()
# sns.despine(offset=10, trim=True)