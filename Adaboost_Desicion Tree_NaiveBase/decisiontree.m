function decisiontree
classLable=zeros(281,1);
training=zeros(281,34);
classLabletest=zeros(281,1);
test=zeros(281,34);

fileID = fopen('ionosphere_training.txt','r'); % r means read
A = fscanf(fileID,'%f');
fileID = fopen('ionosphere_test.txt','r'); % r means read
B = fscanf(fileID,'%f');

for k=1:281
    classLable(k,1)=A(35*k,1);
      
    training(k,1:34)=A(35*(k-1)+1:35*(k-1)+34,1);
end

for k=1:70
    classLabletest(k,1)=B(35*k,1);
       
    test(k,1:34)=B(35*(k-1)+1:35*(k-1)+34,1);
end
 nb=ClassificationTree.fit(training,classLable);
 cpr =nb.predict(test);
  
error=0;
for u=1:70
        if ( cpr(u) ~= classLabletest(u) )
            error=error+1;
        end
end
disp('number of mistakes with decisionTree:');
disp(error);    
    
    
    