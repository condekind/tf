#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import string
import re
import json

import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

from sklearn import linear_model

plt.rcParams['axes.labelsize']  = 20
plt.rcParams['axes.titlesize']  = 26
plt.rcParams['font.family']='monospace'
plt.rcParams['font.size']       = 22
plt.rcParams['legend.fontsize'] = 22
plt.rcParams['xtick.labelsize'] = 20
plt.rcParams['ytick.labelsize'] = 20
plt.rcParams['lines.linewidth'] = 4


# In[ ]:


plotfeatures = [
    ('instcount::Number_of_Load_insts', 'instcount::Number_of_Store_insts'),
    ('instcount::Number_of_instructions_(of_all_types)', 'instcount::Number_of_basic_blocks'),
    ('VarCounter::Number_of_variable_uses_(using_GetNumUses).', 'VarCounter::Number_of_named_variables.'),
    ('EdgeCounter::Number_of_edges.', 'instcount::Number_of_basic_blocks')
]


# In[ ]:


with open("data/stats_all.json", "r+") as finput:
    j = json.load(finput)


# In[ ]:


ff = {(re.sub(r'.*/', '', x['suitename']), re.sub(r'[\_,\.,\,,\-,_,@]+', '_', x['benchname'])) : x['benchdata'] for x in j}

df = pd.DataFrame.from_dict(ff, orient='index').fillna(0).astype(np.int32)


# In[ ]:


plt.rcParams['figure.figsize']  = (24, 18 * len(df.index.unique(0)))
plt.rcParams['font.size']       = 22

tf_regr = {(t[0], t[1]) : {} for t in plotfeatures}
for sx, sy in plotfeatures:
    fx = np.array(df.loc['tf'][sx]).reshape(-1, 1)
    fy = np.array(df.loc['tf'][sy])
    regr = linear_model.LinearRegression()
    regr.fit(fx, fy)
    tf_regr[(sx, sy)]['coef'] = regr.coef_
    tf_regr[(sx, sy)]['intercept'] = regr.intercept_


plt.subplots_adjust(hspace=0.5)
quantile_pct=1
cnt = 0
for suite in df.index.unique(0):
    for sx, sy in plotfeatures:
        fx = np.array(df.loc[suite][sx]).reshape(-1, 1)
        fy = np.array(df.loc[suite][sy])
        
        # arrange plots in a grid
        ax = plt.subplot(len(df.index.unique(0)) * 2, 2, cnt + 1)

        # scatter
        ax.plot(fx, fy, '.r', lw=0.1)

        # diagonal
        x = np.linspace(0, np.max(fx))
        y = x
        ax.plot(x, y, '-k', lw=0.5)

        # suite linear regression
        regr = linear_model.LinearRegression()
        regr.fit(fx, fy)
        fx = np.append(np.array([[0]]), fx)    # 0 avoids a cropped line starting late
        y = fx * regr.coef_ + regr.intercept_  # y = ax + b
        suite_reg_plot = ax.plot(fx, y, '-b', lw=1, label='{}'.format(suite))

        # tf regression for reference
        y = fx * tf_regr[(sx, sy)]['coef'] + tf_regr[(sx, sy)]['intercept']
        tf_reg_plot = ax.plot(fx, y, '-m', lw=1, label='tf')
        
        # line legends. without a title, this is what identifies the plots
        handles, labels = ax.get_legend_handles_labels()
        ax.legend(handles[::-1], labels[::-1])
        
        # line info (slope, angle, etc)
        ax.text(0.01, 1.05, 'Suite ∠ x: {: >6.2f}\nSuite ∠ tf: {: >6.2f}'.format( np.arctan(regr.coef_[0])*(180/np.pi), np.arctan(tf_regr[(sx, sy)]['coef'][0] - regr.coef_[0])*(180/np.pi)), ha='left', transform=ax.transAxes)
        ax.text(0.99, 1.05, 'Suite slope: {: >6.3f}\ntf slope: {: >6.3f}'.format( regr.coef_[0], tf_regr[(sx, sy)]['coef'][0] ), ha='right', transform=ax.transAxes)

        # pretty labels
        ax.set_xlabel(re.sub(r' \(', '\n(', re.sub('_', ' ', re.sub('.*::', '', sx))).title())
        ax.set_ylabel(re.sub(r' \(', '\n(', re.sub('_', ' ', re.sub('.*::', '', sy))).title())
        
        cnt += 1  # need this for subplot management and (if desired) naming plots
        #plt.savefig('data/img/{}_{}.png'.format(suite, (cnt % 4) + 1), format='png')  # individual figures
        #plt.close()  # individual figures
        
plt.savefig('data/all.png', transparent=True, format='png')
#plt.show()


# In[ ]:


#----------------- Median/Quantile -----------------#
# Wanna implement it so that the plots are prettier.
# Currently the outliers stretch the axis' too much.
#----------------- Unfinished work -----------------#

#qntl = 0.5
#suite = 'tf'
#colname = 'instcount::Number_of_Load_insts'
#df.loc[suite][df.loc[suite][colname] <= df.loc[suite][colname].quantile(qntl)][colname]

##df_med = df.loc[suite][df.loc[suite][sx] <= df.loc[suite][sx].quantile(quantile_pct)]
##fxm = np.array(df_med[sx]).reshape(-1, 1)
##fym = np.array(df_med[sy])
#
#fx = np.array(df.loc[suite][sx]).reshape(-1, 1)
#fy = np.array(df.loc[suite][sy])
#
#plt.xlabel(sx)
#plt.ylabel(sy)
#
## scatter
#plt.plot(fx, fy, '.r', lw=0.1)  # plt.plot(fxm, fym, '.r', lw=0.1)
#
## diagonal
#x = np.linspace(0, np.max(fx))  # x = np.linspace(0, np.max(fxm))
#y = x
#plt.plot(x, y, '-k', lw=0.5)

