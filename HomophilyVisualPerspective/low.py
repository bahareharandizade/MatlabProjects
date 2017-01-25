
import json 
from collections import Counter
import numpy as np
from scipy import spatial
from os import listdir
from scipy.stats.stats import pearsonr
import threading
import time
import pickle
### PATHS


# f = open('/Volumes/ADATA1000/Code/EdgeFinalWithMin3rdered.csv','r')

# # don't forget paths must end with '/' or '\'





# USERS_PATH = '/Volumes/ADATA1000/ProfileUsers/UsersLinkProfile/'  #folder containing users list of images
# MATLAB = '/Volumes/ADATA1000/LowFolder/MatlabResult/totalLow.csv' # a single file containing low level features. Please CAT the files in the directory and create a single file
# PLOT = '/Volumes/ADATA1000/LowFolder/ImagePlotResult/all.csv'
# LBP='/Volumes/ADATA1000/lbpResult/alllbp.csv'

# LOW = '/Volumes/Untitled/LowFolder/LowResult/'
## ********************************=************



f = open('E:\\test.csv','r')

# don't forget paths must end with '/' or '\'





USERS_PATH = 'E:\\ProfileUsers\\UsersLinkProfile\\'  #folder containing users list of images
COLOR = 'E:\\LowFolder\\MatlabResult\\total_matlabColor.csv' # a single file containing low level features. Please CAT the files in the directory and create a single file
LBP = 'E:\\lbpResult\\alllbp.csv' 
PLOT = 'E:\\LowFolder\\ImagePlotResult\\all.csv'
LOW= 'E:\\LowFolder\\LowResult\\'


uniq_node = set()
for line in f:
	data = line.strip().split(',')
	uniq_node.add(data[0])
	uniq_node.add(data[1])

f.close()

f = open(PLOT,'r')
plot = {}
for line in f:
	data = line.strip().split(',')
	plot[data[0]] = [float(item) for item in data[1:]]
f.close()

print 'PLOT done'

color = dict()
f = open(COLOR,'r')
for line in f:
	data = line.strip().split(',')
	if data[-1]!='1':	
		color[data[0]] = [float(item) for item in data[1:-1] ]
f.close()

print 'COLOR done'

lbp = dict()
f = open(LBP,'r')
for line in f:
	data = line.strip().split(',')
	if data[-1]!=1:
		lbp[data[-2]] = [float(item) for item in data[:-2] ]
f.close()


print 'lbp done'

## ****************************************

 
def kl(p, q):
	"""Kullback-Leibler divergence D(P || Q) for discrete distributions

	Parameters
	----------
	p, q : array-like, dtype=float, shape=n
	  Discrete probability distributions.
	"""
	try:
		p = np.asarray(p, dtype=np.float)
		q = np.asarray(q, dtype=np.float) 
		return np.sum( np.where(np.all([p!=0 , q!=0],axis=0), p * np.log(p / q), 0) )
	except Exception,x:
		print x

def user_image_list(user_id):
	f = open( USERS_PATH + user_id +'.csv')
	img = list()
	for line in f:
		img.append(line.strip())
	f.close()
	return list(set(img))



f = open(LOW + 'final' ,'w')

def low_corr(user1, user2):
	u1 = list()
	u2 = list()
	
	for img in user_image_list(user1):
		try:
			u1.append((img,color[img]))
		except Exception,x:
			pass

	for img in user_image_list(user2):
		try:
			u2.append((img,color[img]))
		except Exception,x:
			pass

	ColorCorr11 = np.zeros(shape=(len(u1),len(u2)))
	ColorCorr50 = np.zeros(shape=(len(u1),len(u2)))
	LbpCorr = np.zeros(shape=(len(u1),len(u2)))
	PlotCorr = np.zeros(shape=(len(u1),len(u2)))
	# TODO fix KLD
	for i in range(len(u1)):
		for j in range(len(u2)):
			try:
				ColorCorr11[i][j] = kl( u1[i][1][:11] , u2[j][1][:11])
				ColorCorr50[i][j] = kl( u1[i][1][11:61], u2[j][1][11:61])
			except Exception,x:
				pass
			
			try:
				LbpCorr[i][j] = kl( lbp[u1[i][0]] , lbp[u2[j][0]])
			except Exception,x:
				pass

			try:
				PlotCorr[i][j] = 1 - spatial.distance.cosine(plot[u1[i][0]],plot[u2[j][0]])
			except Exception,x:
				pass
	
	out = {}
	out['u1'] = u1
	out['u2'] = u2
	out['color11'] = ColorCorr11
	out['color50'] = ColorCorr50
	out['lbp'] =  LbpCorr
	out['plot'] = PlotCorr

	with open(LOW+'{0}-{1}.pickle'.format(user1,user2), 'wb') as handle:
		pickle.dump(out, handle)
		
	color11_max = max(ColorCorr11.flatten())
	color50_max = max(ColorCorr50.flatten())
	lbp_max = max(LbpCorr.flatten())
	plot_max = max(PlotCorr.flatten())
	
	color11_min = min(ColorCorr11.flatten())
	color50_min = min(ColorCorr50.flatten())
	lbp_min = min(LbpCorr.flatten())
	plot_min = 0

	pp = set(PlotCorr.flatten())
	try:
		if 0 in pp:
			pp.remove(0)
		if pp:
			plot_min = min(pp)
	except Exception,x:
		pass


	color11_avg = ColorCorr11.mean()
	color50_avg = ColorCorr50.mean()
	lbp_avg = LbpCorr.mean()
	
	counter = 0
	plot_avg = 0.0
	for row in PlotCorr:
		for item in row:
			if item:
				plot_avg+=item
				counter+=1
	if counter:
		plot_avg = plot_avg / counter


	f.write(user1+',' + user2+',')
	f.write(str(color11_min)+','+str(color11_avg)+','+str(color11_max)+',')
	f.write(str(color50_min)+','+str(color50_avg)+','+str(color50_max)+',')
	f.write(str(lbp_min)+','+str(lbp_avg)+','+str(lbp_max)+',')
	
	if pp:
		f.write(str(plot_min)+','+str(plot_avg)+','+str(plot_max)+'\n')
	else:
		f.write(',,,\n')
	
	
l = open('E:\\test.csv','r')
counter = 0
for line in l:
	
		data = line.strip().split(',')
 		counter+=1
 		print counter
		low_corr(data[0],data[1])
		#print 'done'
# 		q.write(data[0]+','+data[1]+','+str(1 - spatial.distance.cosine(u1, u2))+',' + str(pearsonr(u1,u2)[0])+',' + str(pearsonr(u1,u2)[1])+'\n')
	
f.close()

