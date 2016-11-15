# -*- coding: utf-8 -*-
"""
Created on Wed Aug  3 11:24:24 2016

@author: miguel
"""

import numpy as np
import matplotlib.pyplot as plot

N = 10
x_max = 1.0
x_min = 0.0
T = 5
t_max = 0.2
t_min = 0.0
delta_t = (t_max-t_min)/(T+1)
delta_x = (x_max - x_min)/ (N + 1)

x_anali = np.linspace(x_min,x_max,N+2)
y_anali = [0.0]*len(x_anali)

for j in range (0,T+2):
     time= t_min + j*delta_t  
     results = 'resultados'+str(j)+'.out'
     x,y=np.loadtxt(results,unpack=True) 
     for i in range(0,N+2):
       x_anali[i] = x_min + i*delta_x
       y_anali[i] = 2*np.exp(-(np.pi**2/4)*time)*np.sin(2*np.pi*x_anali[i])  
     y_anali [0]= 0.0
     y_anali [N+1] =0.0 
     plot.title(u'Ecuación de Calor, tiempo ='+str(time))
     plot.grid(True)
     plot.xlabel('metros')
     plot.ylabel(u'°C')
     plot.xlim(0.0,1.0)
     plot.ylim(-2.0,2.0)     
     plot.plot(x, y, 'D',linewidth=2.0, label="Diferencias finitas")
     plot.plot(x_anali,y_anali,linewidth=2.0,label=u"Solución Analítica")
     plot.legend(loc='lower left', frameon=True)
     plot.savefig(results.rstrip(".out")+'.jpg', dpi=200, bbox_inches='tight',\
             pad_inches=0.2,format='jpg')
     plot.show()