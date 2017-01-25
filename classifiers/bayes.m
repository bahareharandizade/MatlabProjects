clc;
clear all;
close all;

load dataset

[num_of_features,num_of_samples,num_of_classes]=size(X_train);
mu=zeros(num_of_features,num_of_classes);
zigma=zeros(num_of_features,num_of_features,num_of_classes);

for i= 1: num_of_classes
    mu(:,i)=mean(X_train(:,:,i),2);
    zigma(:,:,i)=cov(X_train(:,:,i)');
end

zigma_pool=(1/num_of_classes)*sum(zigma,3);
average_sigma=trace(zigma_pool)/(num_of_features);
alpha=.04;

for l=1:length(alpha)

    for i= 1: num_of_classes
               zigma(:,:,i)=(1-alpha(l))*zigma(:,:,i)+alpha(l)*average_sigma*eye(num_of_features);
    end


    [num_of_features,num_of_test,num_of_classes]=size(X_test);
    p=zeros(num_of_test,num_of_classes);
    confusion_mat=zeros(num_of_classes,num_of_classes);
    confidence_mat=zeros(num_of_classes,num_of_classes);

    for i=1:num_of_classes
        for j=1:num_of_test
            for k=1:num_of_classes
                p(j,k)= mvnpdf(X_test(:,j,i)',mu(:,k)',zigma(:,:,k));
            end
        end
        [m,index]=max(p');
        ps=sort(p,2,'descend');
        for k=1:num_of_classes
            confusion_mat(i,k)=sum((index==k));
        end
        for k=1:num_of_classes
            confidence_mat(i,k)=sum(1-ps((index==k),2)./ps((index==k),1));
        end
    end
    

    CCR(l)=trace(confusion_mat)/sum(sum(confusion_mat));
end
confusion_mat
confidence_mat=confidence_mat./num_of_test
