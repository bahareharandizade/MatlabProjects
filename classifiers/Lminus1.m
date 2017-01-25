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

W=zeros(num_of_features+1,num_of_classes);


for i=1:num_of_classes
    W(:,i)=pinv(X((i-1)*num_of_samples+1:end,:))*B((i-1)*num_of_samples+1:end,i);
end


label=zeros(num_of_test,num_of_classes);

for i=1:num_of_classes
    for j=1:num_of_test
        for c=1:num_of_classes
            if([1; X_test(:,j,i)]'*W(:,c)>0)
                label(j,i)=c;
                break
            end
        end
    end
    for k=1:num_of_classes
        confusion_mat(i,k)=sum((label(:,i)==k));
    end
end


        

CCR=trace(confusion_mat)/sum(sum(confusion_mat))









