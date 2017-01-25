clc;
clear all;
close all;

load dataset


[num_of_features,num_of_samples,num_of_classes]=size(X_train);
[aaa,num_of_test,bbb]=size(X_test);
B=[ones(num_of_samples,1);-ones(num_of_samples,1)];

for i=1:num_of_classes
    for j=i+1:num_of_classes
        X=cat(1,X_train(:,:,i)',X_train(:,:,j)');
        X=cat(2,ones(num_of_samples*2,1),X);
        W(:,i,j)=pinv(X)*B;
    end
end

for i=1:num_of_classes
    for t=1:num_of_test
        for j=1:num_of_classes
            for jj=j+1:num_of_classes
                a(j,jj)=[1;X_test(:,t,i)]'*W(:,j,jj);
            end
        end
        for j=1:num_of_classes
            for jj=j+1:num_of_classes
                a(jj,j)=-a(j,jj);
            end
        end
        aa=sum((a>0),2);
        [m label(t,i)]=max(aa);
      
        
    end
    
    for k=1:num_of_classes
            confusion_mat(i,k)=sum((label(:,i)==k));
    end
    
end


CCR=trace(confusion_mat)/sum(sum(confusion_mat))
            
