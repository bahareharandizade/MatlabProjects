clc;
clear all;
close all;

load dataset

[num_of_features,num_of_samples,num_of_classes]=size(X_train);
mu=zeros(num_of_features,num_of_classes);
zigma=zeros(num_of_features,num_of_features,num_of_classes);

lambda_r=0:.1:1;

lambda_s=1;

for i= 1: num_of_classes
    mu(:,i)=mean(X_train(:,:,i),2);
    zigma(:,:,i)=cov(X_train(:,:,i)');
end

zigma_pool=(1/num_of_classes)*sum(zigma,3);
average_sigma=trace(zigma_pool)/(num_of_features);
alpha=.04;

for i= 1: num_of_classes
               zigma(:,:,i)=(1-alpha)*zigma(:,:,i)+alpha*average_sigma*eye(num_of_features);
end

[num_of_features,num_of_test,num_of_classes]=size(X_test);
p=zeros(num_of_test,num_of_classes);
confusion_mat=zeros(num_of_classes,num_of_classes+1);
confidence_mat=zeros(num_of_classes,num_of_classes);

for l=1:length(lambda_r)

    for i=1:num_of_classes
        for j=1:num_of_test
            for k=1:num_of_classes
                p(j,k)= mvnpdf(X_test(:,j,i)',mu(:,k)',zigma(:,:,k));
            end
        end
        [m,index]=max(p');
        for j=1:num_of_test
            if(m(j)/sum(p(j,:))<= (1-lambda_r(l)/lambda_s))
                index(j)=k+1;
            end
        end
        ps=sort(p,2,'descend');
        for k=1:num_of_classes+1
            confusion_mat(i,k)=sum((index==k));
        end
        for k=1:num_of_classes
            confidence_mat(i,k)=sum(1-ps((index==k),2)./ps((index==k),1));
        end
    end
    
    trace_confusion_mat=0;
    
    for t=1:num_of_classes
            trace_confusion_mat=trace_confusion_mat+confusion_mat(i,i);
    end


    CCR(l)=trace_confusion_mat/sum(sum(confusion_mat));
    pe(l)=(sum(sum(confusion_mat))-trace_confusion_mat-sum(confusion_mat(:,num_of_classes+1)))/sum(sum(confusion_mat));
end



plot(lambda_r,CCR)
figure
plot(lambda_r,pe)

