


import time
from numpy import array
import glob

import matplotlib.pyplot as plt
from scipy import stats
import numpy as np

types = ['close','linkFriend','NotFriend']

cases = ['NotOPT/lable','OPT/lable','NotOPT/NOUN','OPT/NOUN']

PATH = '/media/bahareh/ADATA1000/LowTest2/relation1/'




data = dict()


for case in cases:
	data[case] = list()
	result = dict()
	for ty in types:
		result[ty] = list()
		path = PATH.format(ty,case)
		files = glob.glob(path + 'final*')
		for f in files:
			#print f
			ff = open(f,'r')
			tmp = list()
			for line in ff:
				try:
					tmp.append(float(line.strip().split(',')[2]))
				except Exception,x:
					print x
			result[ty].append(tmp)
	data[case] = result



for case in cases:
	print case
	notfriend = array(data[case]['NotFriend'])
	link = array(data[case]['linkFriend'])
	#close = array(data[case]['close'])
	plt.figure()


	x = [1,2,3]
	plt.xticks(x , [ 'Not-Friend', 'Link' ])
	plt.title(case)
	a = [notfriend.mean(axis=1).mean(),link.mean(axis=1).mean()]
	print a
	error = list()
	error.append(stats.sem(notfriend,axis=1).mean())
	error.append(stats.sem(link,axis=1).mean())
	print error
	plt.errorbar([1,2,3],a,yerr=error, linestyle="None", fmt='o')
	plt.show()




