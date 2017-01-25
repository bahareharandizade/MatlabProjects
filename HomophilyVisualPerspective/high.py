
import json # :|
from collections import Counter
import numpy as np
from scipy import spatial
from os import listdir
from scipy.stats.stats import pearsonr
import threading
import time
### PATHS


f = open('E:\\Code\\EdgeFinalWithMin3rdered.csv','r')

# don't forget paths must end with '/' or '\'

USERS_PATH = 'E:\\ProfileUsers\\UsersLinkProfile\\'  #folder containing users list of images
DEEP = 'E:\\HighFolder\\Data\\DeepFolder\\DeepResult_ByimageName\\result\\'   # folder containing jsons for each image
TEXT = 'E:\\HighFolder\\Data\\TextResult\\FinalTag.txt' # a single file containing text feature. Please CAT the files in the directory and create a single file
FACE = 'E:\\HighFolder\\Data\\face\\face\\' # folder containing jsons for each image
HIGH_RESULT = 'E:\\HighFolder\\HighResult\Vector\\'  # single file
HIGHVECT='E:\\HighFolder\\HighResult\Vector\\'
Co_occurance='E:\\HighFolder\\Data\DeepFolder\\co-occurrence.txt'
TAG = 'E:\\HighFolder\\lable\\'
NOUN='E:\\HighFolder\\OptNOUN\\'
## ********************************=************

uniq_node = set()
for line in f:
	data = line.strip().split(',')
	uniq_node.add(data[0])
	uniq_node.add(data[1])

f.close()

#print 'uniq done'
#
tmp = json.load(open('E:\\classes.json','r'))
classes = {value: idx for idx, value in enumerate(tmp)}

#text_result = dict()
#f = open(TEXT,'r')
#for line in f:
#	data = line.strip().split(',')
#	if data:
#		if data[-1]!=1:
#			text_result[data[0]] = data[1]
#
#f.close()

#f = open(PLOT,'r')
#plot = {}
#for line in f:
#	data = line.strip().split(',')
#	plot[data[0]] = data[1:]

#f.close()

#mat_result = dict()
#f = open(MATLAB,'r')
# for line in f:
	# continue
	# data = line.strip().split(',')
	# if data[-1]!=1:
		# mat_result[data[-2]] = data[:-2]

# f.close()

#print 'mat done'

## ****************************************

 
def kl(p, q):
	"""Kullback-Leibler divergence D(P || Q) for discrete distributions

	Parameters
	----------
	p, q : array-like, dtype=float, shape=n
	  Discrete probability distributions.
	"""
	p = np.asarray(p, dtype=np.float)
	q = np.asarray(q, dtype=np.float) 
	return np.sum(np.where(p != 0, p * np.log(p / q), 0))

def user_image_list(user_id):
	f = open( USERS_PATH + user_id +'.csv')
	img = list()
	for line in f:
		img.append(line.strip())
	f.close()
	return list(set(img))


def _calculate_highlevel_vector(img):
	try:
		result = [0 for i in range(2098)]

		# deep(2098)  
		deep = open(DEEP + img.split('.jpg')[0]+'.json','r')
		deep_result = json.load(deep)['bi-concepts']
		deep.close()
		top_1000 = dict(Counter(deep_result).most_common(1000))
		
		for key in top_1000.keys():
			result[classes[key]] = top_1000[key]
			
		# text
		#result[2098] = text_result[img]
		# having face or not
		#try:
			#tt = open(FACE+img.split('.jpg')[0],'r')
			#face = json.load(tt)['face']	
			#tt.close()
			##if face:
				#result[2099] = 1
		#except Exception,x:
			#pass
		return result
	except Exception,x:
		return result
	
	
def _calculate_face_feature(user_id):
	try:
		result = list()
		user_img = user_image_list(user_id)
		male = 0
		female = 0
		smile = 0
		age = 0
		race = list()	
		f_count = 0
		for img in user_img:
			try:
				img = img.split('.jpg')[0] 
				ff = open(FACE + img,'r')
				data = json.load(ff)
				ff.close()
				if data['face']:
					for item in data['face']:
						f_count +=1
						face = item['attribute']
						age+=(face['age']['value'])
						if face['gender']['value'] == 'Female':
							female+=1
						elif face['gender']['value']=='Male':
							male+=1
						race.append(face['race']['value'])		
						smile+= face['smiling']['value']
			except Exception,x:
				pass
		if f_count:
			race = Counter(race).most_common(1)[0][0]
			if race=='White':
				race = 0
			elif race=='Asian':
				race=1
			else:
				race =2
			smile = float(smile) / f_count
			male = float(male) / f_count
			female = float( female ) / f_count
			age = float( age )/ f_count
			res = [age,male,female,race,smile]
			return res
		else:
			return [0,0,0,0,0]
	except Exception,x:
		return [0,0,0,0,0]
	
	

def user_high_vector(user_id):
	result = list()
	user_img = user_image_list(user_id)
	for img in user_img:
		res = _calculate_highlevel_vector(img)
		if res!=-1:
			result.append(res)
	if result:
		tmp = list()
		for i in range(len(result[0])):
			t = 0
			for j in range(len(result)):
				try:
					t+=float(result[j][i])
				except Exception,x:
					#print x
					print j,i
					print result[j]
			if t:
				tmp.append(t/len(result))
			else:
				tmp.append(0)
		result = tmp
		#result = np.mean(result,axis=1)
		#result+=_calculate_face_feature(user_id)
		z = open(HIGH_RESULT + user_id,'w')
		z.write(str(result[0]))
		for item in result[1:]:
			z.write(','+str(item))
		z.close()
		print 'done'
	else:
		result =  [0 for i in range(2098)]
		z = open(HIGH_RESULT + user_id,'w')
		z.write(str(result[0])+',')
		for item in result[1:]:
			z.write(','+str(item))
		z.close()
		print 'done'
	

#print 'start creating high'

#done = set( [f for f in listdir(HIGH_RESULT)])
#problem = list()
#
#
#high_feature = dict()
#counter = 0
#print len(uniq_node)
#th_list = list()

#for user in uniq_node:
#	counter+=1
#	#print counter
#	#if user in done:
#		#continue
#	try:
#		print user
#		th = threading.Thread(target= user_high_vector , args = [user])
#		th.start()
#		th_list.append(th)
#		if len(th_list) > 15:
#			flag = True
#			while flag:
#				for th in th_list:
#					if not th.isAlive():
#						th.join()
#						th_list.remove(th)
#						flag = False
#						break
#				time.sleep(1)
#	except Exception,x:
#		problem.append(user)
#		
#print len(th_list)
#
#for th in th_list:
#	th.join()
#		
#print problem 		

done = set( [f for f in listdir(HIGHVECT)] )
high_feature = dict()

for item in done:
	print item
	ff = open(HIGHVECT+item,'r')
	data = ff.readline().strip().split(',')
	high_feature[item] = [float(i) for i in data]
	ff.close()
	
print 'high done!!!'

problem =list()

l = open('E:\\Code\\EdgeFinalWithMin3rdered.csv','r')
q = open(HIGH_RESULT+'final_Deep','w')
counter = 0
for line in l:
	
		data = line.strip().split(',')
		counter+=1
		print counter
		u1 = high_feature[data[0]]
		u2 = high_feature[data[1]]
		if len(u1)==0:
			problem.append(data[0])
		if len(u2)==0:
			problem.append(data[1])
			
		q.write(data[0]+','+data[1]+','+str(1-spatial.distance.correlation(u1, u2))+','+str(1 - spatial.distance.cosine(u1, u2))+',' + str(pearsonr(u1,u2)[0])+',' + str(pearsonr(u1,u2)[1])+'\n')
	
		


print set(problem)
		
l.close()
q.close()



#imgs = set(plot.keys())
	
