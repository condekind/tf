#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import re
import json
#from copy import copy      # used to save plots. watch your memory.
#from pprint import pprint  # pretty iterables

import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

from sklearn import linear_model
from sklearn.metrics import explained_variance_score, mean_absolute_error, mean_squared_error, r2_score

plt.rcParams['axes.labelsize']  = 20
plt.rcParams['axes.titlesize']  = 26
plt.rcParams['font.family']='monospace'
plt.rcParams['font.size']       = 22
plt.rcParams['legend.fontsize'] = 22
plt.rcParams['xtick.labelsize'] = 20
plt.rcParams['ytick.labelsize'] = 20
plt.rcParams['lines.linewidth'] = 4


# In[ ]:


# json load
with open("data/stats_all.json", "r+") as finput:
    j = json.load(finput)

# remove punctuation
trash = r'[\_,\.,\,,\-,_,@,\:,\(,\)]+'
ff = {(re.sub(r'.*/', '', x['suitename']), re.sub(trash, '_', x['benchname'])) : {re.sub('\_$', '', re.sub(trash, '_', k.lower())): v for k, v in x['benchdata'].items()} for x in j}

# to dataframe
df = pd.DataFrame.from_dict(ff, orient='index').fillna(0).astype(np.int32)

# save memory
del(j)

# suite names
suites = df.index.unique(0)

# x, y
plotfeatures = [
    ('instcount_number_of_load_insts', 'instcount_number_of_store_insts'),
    ('instcount_number_of_instructions_of_all_types', 'instcount_number_of_basic_blocks'),
    ('varcounter_number_of_variable_uses_using_getnumuses', 'varcounter_number_of_named_variables'),
    ('edgecounter_number_of_edges', 'instcount_number_of_basic_blocks'),
]

# {'suite1': {'X1,Y1': {'stat1': 5, 'stat2': 10}, 'X2,Y2': {'stat1': 5, 'stat2': 10}}, 'suite2':{{..}..}..}
stats = {x: {sx + '_x_' + sy: {} for sx, sy in plotfeatures} for x in suites if x != 'tf' }


# In[ ]:


df.head()


# <br><div style="border:none;width:100%;height:4px;color:#000;background-color:#000;"></div>
# # <center>Linear Regression - Stats</center>

# In[ ]:


stats = {x: {sx + '_x_' + sy: {} for sx, sy in plotfeatures} for x in suites if x != 'tf' }
# tf regression
tf_regr = {(t[0], t[1]) : {} for t in plotfeatures}
for sx, sy in plotfeatures:
    fx = np.array(df.loc['tf'][sx]).reshape(-1, 1)
    fy = np.array(df.loc['tf'][sy])
    regr = linear_model.LinearRegression()
    regr.fit(fx, fy)
    tf_regr[(sx, sy)]['coef'] = regr.coef_
    tf_regr[(sx, sy)]['intercept'] = regr.intercept_
    print(explained_variance_score(fy, regr.coef_ *fx + regr.intercept_))

# suites' regressions
for suite in [s for s in suites if s != 'tf']:
    for sx, sy in plotfeatures:

        if sx + '_x_' + sy not in stats[suite]:
            stats[suite][sx + '_x_' + sy] = {}

        fx = np.array(df.loc[suite][sx]).reshape(-1, 1)
        fy = np.array(df.loc[suite][sy])

        ## suite linear regression
        regr = linear_model.LinearRegression()
        regr.fit(fx, fy)
        y_reg = fx * regr.coef_ + regr.intercept_  # y = ax + b

        ## tf regression on suite's X for reference
        y_tf = fx * tf_regr[(sx, sy)]['coef'] + tf_regr[(sx, sy)]['intercept']
        
        stats[suite][sx + '_x_' + sy]['mse_self']   = mean_squared_error(fy, y_reg)
        stats[suite][sx + '_x_' + sy]['mae_self']   = mean_absolute_error(fy, y_reg)
        stats[suite][sx + '_x_' + sy]['evs_self']   = explained_variance_score(fy, y_reg)
        stats[suite][sx + '_x_' + sy]['r2s_self']   = r2_score(fy, y_reg)
        stats[suite][sx + '_x_' + sy]['mseRegr_tf'] = mean_squared_error(y_reg, y_tf)
        stats[suite][sx + '_x_' + sy]['maeRegr_tf'] = mean_absolute_error(y_reg, y_tf)
        stats[suite][sx + '_x_' + sy]['evsRegr_tf'] = explained_variance_score(y_reg, y_tf)
        stats[suite][sx + '_x_' + sy]['r2sRegr_tf'] = r2_score(y_reg, y_tf)
        stats[suite][sx + '_x_' + sy]['mseTrue_tf'] = mean_squared_error(fy, y_tf)
        stats[suite][sx + '_x_' + sy]['maeTrue_tf'] = mean_absolute_error(fy, y_tf)
        stats[suite][sx + '_x_' + sy]['evsTrue_tf'] = explained_variance_score(fy, y_tf)
        stats[suite][sx + '_x_' + sy]['r2sTrue_tf'] = r2_score(fy, y_tf)

print('done')


# In[ ]:


midx = pd.MultiIndex.from_tuples([(suite, title) for suite, v in stats.items() for title in v.keys()])
stdt = [dt for v in stats.values() for dt in v.values()]

table_stats = pd.DataFrame(data=stdt, index=midx)
stats_html  = table_stats.to_html()

table_stats


# In[ ]:


print(stats_html)


# <br><div style="border:none;width:100%;height:4px;color:#000;background-color:#000;"></div>
# # <center>Linear Regression - Plots</center>

# In[ ]:


plt.rcParams['figure.figsize']  = (12, 8)
plt.rcParams['font.size']       = 22

plt.subplots_adjust(hspace=0.5)
cnt = 0
for suite in df.index.unique(0):
    for sx, sy in plotfeatures:
        
        fx = np.array(df.loc[suite][sx]).reshape(-1, 1)
        fy = np.array(df.loc[suite][sy])
        
        ax = plt.subplot()
        
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
        ax.plot(fx, y, '-b', lw=1, label='{}'.format(suite))

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
        
        plt.savefig('data/img/{}_{}.png'.format(suite, (cnt % 4) + 1), format='png')  # individual figures
        plt.close()  # individual figures
        
print('done')


# <br><div style="border:none;width:100%;height:4px;color:#000;background-color:#000;"></div>
# # <center> T-test </center>

# In[ ]:


# X_TF = list of every ratio "number of variables"/"number of uses" per program in TF.
# X_An = same thing, but for Angha.


# In[ ]:


### mad science tests
## class Point2d:
##     def __init__(self, vx=0, vy=0):
##         self.x = vx
##         self.y = vy
##     def __add__(self, other):
##         return Point2d(self.x + other.x, self.y + other.y)
##     def __str__(self):
##         return '({}, {})'.format(self.x, self.y)


# <br><div style="border:none;width:100%;height:4px;color:#000;background-color:#000;"></div>
# # <center> Median/Quantile feature plots </center>

# In[ ]:


##------------------ Median/Quantile ------------------#
## Wanna implement it so that the plots make more sense.
## Currently the outliers stretch the axis' too much.
##------------------ Unfinished work ------------------#

#q25, q75 = df['instcount::Number_of_instructions_(of_all_types)'].quantile([0.25, 0.75])

#quantile_pct=1
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

