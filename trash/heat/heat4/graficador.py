# -*- coding: utf-8 -*-
"""
Created on Fri Jul 22 09:50:41 2016

@author: miguel
"""
import sys
import numpy as np
import matplotlib.pyplot as plot
results = str(sys.argv[1])
data = np.loadtxt(results)
x,y=np.loadtxt(results,unpack=True) 
plot.title(u'Ecuación Calor')
plot.grid(True)
plot.xlabel('metros')
plot.ylabel(u'°C')
plot.plot(x, y, linewidth=2.0)
plot.plot(*np.loadtxt(results,unpack=True), linewidth=2.0)
plot.savefig(results.rstrip(".out")+'.jpg', dpi=200, bbox_inches='tight', pad_inches=0.2,format='jpg')
plot.show()
