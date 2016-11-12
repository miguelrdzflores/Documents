# -*- coding: utf-8 -*-
"""
Created on Mon Jul 11 12:39:50 2016

@author: miguel
"""
import numpy as np
import matplotlib.pyplot as plot
data = np.loadtxt("results.dat")
x,y=np.loadtxt("results.dat",unpack=True) 
plot.plot(x, y, linewidth=2.0)
plot.plot(*np.loadtxt("results.dat",unpack=True), linewidth=2.0)
plot.show()