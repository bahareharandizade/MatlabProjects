function adaboost(M,T,Model)%if Model is 1=NaiveBayes and if Model is 2=descion tree
[dataprim,classprim]=readfile();
Zt=0;
count=0;
Error=0.0;
N=281;
D=zeros(1,281);
a=zeros(1,T);
e=zeros(1,T);
numberofmistakes=zeros(1,T);
numberofcorrect=zeros(1,T);
final=zeros(1,N);
h=zeros(N,T);
axis=zeros(1,T);
for k=1:N
    D(k)= 1.0/281;
end

for t=1:T
    axis(t)=t;
   [data,classLable]=readfile();
   
    tmp=1;
	SumD=0.0;
	for i=1:N
        SumD=D(i)+SumD;
    
    end
	while tmp <N-M+1
	     test=rand(1);
         wi=(D(tmp)/SumD)*100;
		 if test>wi
		
	    	data(tmp,:)=[];
            classLable(tmp)=[];		
         
         end
         tmp=tmp+1;
    end
    if Model==1
        nb{t}=NaiveBayes.fit(data,classLable,'dist','kernel');
    else
        nb{t}=ClassificationTree.fit(data,classLable);
    end
    cpr{t} =nb{t}.predict(dataprim);
    
  
    for u=1:281
        if ( cpr{t}(u) ~= classprim(u) )
            I(u)=1.0; 
            numberofmistakes(t)=numberofmistakes(t)+1;
        else
            numberofcorrect(t)=numberofcorrect(t)+1;
            I(u)=0.0;
        end
        h(t,u)=cpr{t}(u);
    end
%     accuracy=100 * numberofcorrect(t) / N;
%     Error=(numberofmistakes/(numberofcorrect+numberofmistakes))+Error;
%     count=count+1;
    
    for n=1:N
        e(t)=e(t)+(I(n)*D(n));
    end
    if(e(t)>0.5 || t==T-1)
        break;
    end
    a(t)=0.5*log((1-e(t))/e(t));%compute at

    for n=1:N%compute Zt
			
		if (I(n)==1.0) 
			Zt=Zt+(D(n)*exp(a(t)*1.0));
        else
			Zt=Zt+(D(n)*exp(a(t)*0.0));
        end
    end
    for n=1:N%compute Zt
			
		if (I(n)==1.0) 
			D(n)=(D(n)*exp(a(t)*1.0))/Zt;
        else
		    D(n)=(D(n)*exp(a(t)*0.0))/Zt;
        end
    end
				
end
for k=1:N
    for t=1:T
        final(k)=final(k)+a(t)*h(t,k); 
    end
    final(k)=sign(final(k));
end
sum=0;
for k=1:N
    if ( final(k) ~= classprim(k) )
        sum=sum+1; 
    end
end 
if Model==1
disp('number of mistakes-adaboost with naive bayes:');
else
  disp('number of mistakes-adaboost with decsionTree:');  
end
disp(sum);
subplot(2,1,1); 
plot(axis,e);
xlabel('training number');
ylabel('error rate');
% hold on
subplot(2,1,2); 
plot(axis,numberofmistakes);
xlabel('testing number');
ylabel('number ot mistakes');
% hold off



    

function [training,classLable]=readfile()
classLable=zeros(281,1);
training=zeros(281,34);
fileID = fopen('ionosphere_training.txt','r'); % r means read
A = fscanf(fileID,'%f');

for k=1:281
    classLable(k,1)=A(35*k,1);
        if ( classLable(k,1)== 2 )
            classLable(k,1)= -1 ;
        end
    training(k,1:34)=A(35*(k-1)+1:35*(k-1)+34,1);
end
