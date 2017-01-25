clc;
clear all;
close all;

load dataset


[num_of_features,num_of_samples,num_of_classes]=size(X_train);
[a,num_of_test,b]=size(X_test);

K=1:50;

for l=1:length(K)

    for i=1:num_of_classes
            estimated_pdf=zeros(num_of_test,num_of_classes);
            for j=1:num_of_test

                for ii=1:num_of_classes
                    for n=1:num_of_samples
                        distance(n,ii)=norm(X_train(:,n,ii)-X_test(:,j,i),2);
                    end

                end
                [sorted_dis index]=sort(distance);
                for c=1:num_of_classes
                    estimated_pdf(j,c)=(K(l)-1)/(num_of_samples*volume(sorted_dis(K(l),c)));
                    [m label(j,i)]=max(estimated_pdf(j,:));
     %               [m2 index]=sort(estimated_pdf(i,j,:),'descend');
    %                label2(j,i)=index(2);
                end


            end
             sorted_estimated_pdf=sort(estimated_pdf,2,'descend');
            for n=1:num_of_classes
                confusion_mat(i,n)=sum((label(:,i)==n));
            end
            for n=1:num_of_classes
               confidence_mat(i,n)=sum(1-sorted_estimated_pdf((label(:,i)==n),2)./sorted_estimated_pdf((label(:,i)==n),1));
            end
        end
        CCR(l)=trace(confusion_mat)/sum(sum(confusion_mat));
end

plot(K,CCR)
    
    
    
    
    
    
    
    