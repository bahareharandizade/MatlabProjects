clc;
clear all;
close all;

load dataset


[num_of_features,num_of_samples,num_of_classes]=size(X_train);
[a,num_of_test,b]=size(X_test);

X=X_train(:,:,1)';

for c= 2: num_of_classes
    X= cat(1,X,X_train(:,:,c)');
end

X=cat(2,ones(num_of_samples*num_of_classes,1),X);

B=zeros(num_of_samples*num_of_classes,num_of_classes);

for i=1:num_of_classes
    for j=1:num_of_classes
        if(j==i)
            B((j-1)*num_of_samples+1:j*num_of_samples,i)=ones(num_of_samples,1);
        else
             B((j-1)*num_of_samples+1:j*num_of_samples,i)=-ones(num_of_samples,1);
        end
    end
end

W=pinv(X)*B;



for i=1:num_of_classes
    
        [m index]=max(([ones(1,num_of_test) ;X_test(:,:,i)]'*W)');
        for k=1:num_of_classes
            confusion_mat(i,k)=sum((index==k));
        end

    
end
CCR=trace(confusion_mat)/sum(sum(confusion_mat))
confusion_mat