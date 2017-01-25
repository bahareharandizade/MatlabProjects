clc;
clear all;
close all;

load dataset

[num_of_features,num_of_samples,num_of_classes]=size(X_train);

[~,num_of_test,~]=size(X_test);

h=2.4
%h=.1:.1:3.5;
for l=1:length(h)
    for i=1:num_of_classes
        c=zeros(num_of_test,num_of_classes);
        for j=1:num_of_test

            for ii=1:num_of_classes
                for k=1:num_of_samples
                    c(j,ii)=c(j,ii)+parzen_window((X_test(:,j,i)-X_train(:,k,ii))./h(l));
                end

            end
            [mvalue label(j,i)]=max(c(j,:));

        end
         cs=sort(c,2,'descend');
        for k=1:num_of_classes
            confusion_mat(i,k)=sum((label(:,i)==k));
        end
        for k=1:num_of_classes
            confidence_mat(i,k)=sum(1-cs((label(:,i)==k),2)./cs((label(:,i)==k),1));
        end
    end
    CCR(l)=trace(confusion_mat)/sum(sum(confusion_mat));
end

plot(h,CCR)
        