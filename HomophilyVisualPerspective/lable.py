from os import listdir
import json
import operator
from collections import Counter

USERS_PATH = 'E:\\ProfileUsers\\UsersLinkProfile\\'  #folder containing users list of images
DEEP = 'E:\\HighFolder\\Data\\DeepFolder\\DeepResult_ByimageName\\result\\'   # folder containing jsons for each image
TEXT = 'E:\\HighFolder\\Data\\TextResult\\FinalTag.txt' # a single file containing text feature. Please CAT the files in the directory and create a single file
FACE = 'E:\\HighFolder\\Data\\face\\face\\' # folder containing jsons for each image


TAG = 'E:\\HighFolder\\test3\\lable16\\'
NOUN='E:\\HighFolder\\test3\\NOUN16\\'
f=open('E:\\Sample\\Sample10\\EdgeFinalWithMin10rdered.csv','r')
uniq_node = set()
for line in f:
        data = line.strip().split(',')
        uniq_node.add(data[0])
        uniq_node.add(data[1])

f.close()


def user_image_list(user_id):
        f = open( USERS_PATH + user_id +'.csv')
        img = list()
        for line in f:
                img.append(line.strip())
        f.close()
        return list(set(img))


def create_tag_vector(user):
        imgs = user_image_list(user)
        total_tag = list()
	total_noun=list()
        for img in imgs:
		try:
                    deep = open(DEEP + img.split('.jpg')[0]+'.json','r')
                    deep_result = json.load(deep)['bi-concepts']
                    deep.close()
                    #nimg=set()
                    mostcommon=Counter(deep_result).most_common(16)
                    total_tag+= list(set(item[0].strip() for item in mostcommon))
                    total_noun+=list(set((item[0].strip().split('_'))[1] for item in mostcommon))
                    
   #                 for item in Counter(deep_result).most_common(16):
   #                                                     
			#				#total_tag.append(item[0])
			#				name = item[0].strip().split('_')
			#
			#				
			#				nimg.add(name[1])
		 #   total_noun+=list(nimg)
		except Exception,x:
			pass
        result = sorted(Counter(total_tag).items(), key=operator.itemgetter(1),reverse=True)
	result2 = sorted(Counter(total_noun).items(), key=operator.itemgetter(1),reverse=True)
	print "Res1:"+str(len(result))
        print "Res2:"+str(len(result2))
        f = open(TAG+user,'w')
	f1= open(NOUN+user,'w')
	f.write(str(len(imgs))+'\n')
	f1.write(str(len(imgs))+'\n')
        for item in result:
            f.write(str(item[0])+':'+str(item[1])+'\n')
        for item in result2:
            f1.write(str(item[0])+':'+str(item[1])+'\n')	
        f.close()
        f1.close()


counter = 0
for user in uniq_node:
        #if user in done:
        #        continue
        create_tag_vector(user)
        counter+=1
        print counter

