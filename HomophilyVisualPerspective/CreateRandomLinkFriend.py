from os import listdir
import json
import operator
from collections import Counter
from scipy import spatial
from scipy.stats.stats import pearsonr
from collections import OrderedDict
import random

USERS_PATH = 'E:\\ProfileUsers\\UsersLinkProfile\\'  #folder containing users list of images
DEEP = 'E:\\HighFolder\\Data\\DeepFolder\\DeepResult_ByimageName\\result\\'   # folder containing jsons for each image
TEXT = 'E:\\HighFolder\\Data\\TextResult\\FinalTag.txt' # a single file containing text feature. Please CAT the files in the directory and create a single file
FACE = 'E:\\HighFolder\\Data\\face\\face\\' # folder containing jsons for each image
HIGH_RESULT = 'E:\\HighFolder\\NOUN\\'  # single file
Co_occurance='E:\\HighFolder\\Data\DeepFolder\\co-occurrence.txt'
#TAG = 'E:\\HighFolder\\test3\\lable16\\'
TAG = 'E:\\HighFolder\\test\\optlable16\\'
NOUN='E:\\HighFolder\\test\\optlable16\\'
#NOUN='E:\\HighFolder\\NOUN16\\'



#
#pairCFriend=list()
#Cffile=open('E:\\Sample\\Sample10\\closefMin10.txt','r')
#for line in Cffile:
#    data = line.strip().split(',')
#    pairCFriend.append(data[0]+','+data[1]+','+data[2]+','+data[3]+','+data[4])
#Cffile.close()
#
#pairlFriend=list()
#lffile=open('E:\\Sample\\Sample10\\EdgeFinalWithMin10rdered.csv','r')
#for line in lffile:
#    data = line.strip().split(',')
#    pairlFriend.append(data[0]+','+data[1]+','+data[2]+','+data[3]+','+data[4])
#lffile.close()
#
#
#for i in range(1,11):
#    notCommon=list(set(pairlFriend)-set(pairCFriend))
#    Lff=open('E:\\Sample\\Sample10\\linkFriend'+str(i),'w')
#    rand=random.sample(range(1, len(notCommon)), 159)
#    counter=0
#    print len(notCommon)
#    print rand
#    for item in rand:
#        data = notCommon[item].strip().split(',')
#        Lff.write(data[0]+','+data[1]+','+data[2]+','+data[3]+','+data[4]+'\n')
#        counter+=1
#        print counter
#    
#    Lff.close() 


#        
jsonFile=open('E:\\classes.json','r')
tmp = json.load(jsonFile)
jsonFile.close()
tmp.append('Text')
tmp.append('Face')
classes = {value: idx for idx, value in enumerate(tmp)}
#
#tmp = json.load(jsonFile)
#jsonFile.close()
#tmpclasses = OrderedDict({value: idx for idx, value in enumerate(tmp)})
#classes=dict()
#
#counter=0
#for i in tmpclasses.keys():
#	if i.split('_')[-1] not in classes:
#	        if(i.split('_')[-1]=='text'):
#	              
#		      classes['Text']=counter
#		      counter+=1
#	        else:
#		      classes[i.split('_')[-1]]=counter
#		      counter+=1



		      
		      
		      

def CreateTagVect(user):
    lableUsers=dict()
    f=open(TAG+user,'r')
    result = [0 for i in range(2091)]
    f.readline()
    for line in f:
            data = line.strip().split(':')
            lableUsers[data[0]]=data[1]
        
    for key in lableUsers.keys():
	result[classes[key]] = int(lableUsers[key])
    
    return result


def CreateNounVect(user):
    lableUsers=dict()
    f=open(NOUN+user,'r')
    result = [0 for i in range(len(classes))]
    f.readline()
    for line in f:	
            data = line.strip().split(':')
            if data[0]!='text'and data[0]!='Face':
                lableUsers[data[0]]=data[1]
        
    for key in lableUsers.keys():
		
		result[classes[key]] = int(lableUsers[key])
    
    return result
problem =list()
for i in range(1,11):
    l = open('E:\\Sample\\Sample10\\linkFriend'+str(i),'r')
    q = open('E:\\Sample\\Sample10\\final'+str(i),'w')
    counter = 0
    for line in l:
	
		data = line.strip().split(',')
		counter+=1
		print counter
		u1 = CreateTagVect(data[0])
		u2 = CreateTagVect(data[1])
		
		if len(u1)==0:
			problem.append(data[0])
		if len(u2)==0:
			problem.append(data[1])
			
		q.write(data[0]+','+data[1]+','+str(1-spatial.distance.correlation(u1, u2))+','+str(1 - spatial.distance.cosine(u1, u2))+',' + str(pearsonr(u1,u2)[0])+',' + str(pearsonr(u1,u2)[1])+'\n')
    q.close()	
		


print set(problem)

l.close()