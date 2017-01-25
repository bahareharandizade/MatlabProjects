import glob
import json
import operator
from collections import Counter
import copy
from os import listdir


top20 = 'E:\\HighFolder\\optlableNew\\'
path = 'E:\\HighTest\\500image\\'
json_path = 'E:\\HighFolder\\Data\\DeepFolder\\DeepResult_ByimageName\\result\\'

#names = glob.glob(path+'*.txt')
# f = open('random','r')
# names = [line.strip() for line in f]

names = set([f for f in listdir('E:\\AvailableImage')])
co = dict()
f = open('E:\\HighFolder\\Data\\DeepFolder\\co-occurrence.txt','r')


for line in f:
	tmp = line.strip().split(':')
	co[tmp[0]] = tmp[1].split(',')


result = dict()



counter = 0

for name in names:
	try:
		name = name.split('/')[-1]
		g=open( json_path + name.split('.jpg')[0] + '.json','r')
		data = json.load(f)
		f.close()
		x = data['bi-concepts']
		sorted_x = sorted(x.items(), key=operator.itemgetter(1) , reverse=True)
		result[name.split('/')[-1]] = [item[0] for item in sorted_x[:30]]
		counter+=1
	except Exception,x:
		print x

modify = copy.deepcopy(result)
print modify

for media in modify:
	print media
	ok = list()
	flag = True
	for i in range(len(result[media])):
		try:
			s = set(co[result[media][i]]).intersection(set(result[media][:10]))
			if not len(s) >=1:
				if len(ok)==1:
					for item in co[ok[0]]:
						if item not in modify[media]:
							print result[media][i],' ----> ',item
							modify[media][i] = item
							flag = False

				elif len(ok)>=1:
					tmp = list()
					for tag in ok:
						tmp+=co[tag]
					tmp = Counter(tmp).most_common()
					for item in tmp:
						if item[0] not in modify[media]:
							flag = False
							print result[media][i],' ----> ',item
							modify[media][i] = item[0]
							break

			else:
				ok.append(modify[media][i])

			f = open(top20+media.split('.jpg')[0],'w')
			for item in modify[media]:
				f.write(item+':\n')
			f.close()

		except Exception,x:
			print x

	if flag:
		print '******* NO REFINEMENT ******'




