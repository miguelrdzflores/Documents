# -*- coding: utf-8 -*-
"""
Created on Wed Aug  3 11:24:24 2016

@author: miguel
"""

import numpy as np
import matplotlib.pyplot as plot


N = 4
x_max = 0.54545
x_min = 0.45455
t_max = 0.2
t_min = 0.0
delta_t = (t_max-t_min)/(24)
delta_x = (x_max - x_min)/ (N + 1)

for j in range (0,20):
     time= 0.033333333 + j*delta_t  
     results = 'refin_'+str('{:05.3f}'.format(time))+'.out'
     x,y=np.loadtxt(results,unpack=True) 
     plot.title(u'Refinamiento de Ec. de Calor, t='+str('{:05.3f}'.format(time)))
     plot.grid(True)
     plot.xlabel('metros')
     plot.ylabel(u'°C')
     plot.xlim(0.4545,0.54545)
     plot.ylim(-0.6,0.6)     
     plot.plot(x, y,linewidth=2.0, label="Diferencias finitas")
     plot.legend(loc='lower left', frameon=True)
     plot.savefig(results.rstrip(".out")+'.jpg', dpi=200, bbox_inches='tight',\
             pad_inches=0.2,format='jpg')
     plot.show()