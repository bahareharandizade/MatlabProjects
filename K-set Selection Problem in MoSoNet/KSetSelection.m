function [Kset,TotalOpt]=KSetSelection(nodes,NodePosition,T,B,K,PNodes)
MinDistance=3;
TotalInfect=zeros(nodes,1);
Kset=zeros(K,1);
nodes=nodes-1;
for i=1:nodes
    t=1;
    InfectedNodes=zeros(nodes,1);
    InfectedNodes(i)=1;
    
    while t<T
        InfectN=find(InfectedNodes,1);
        for j=1:length(InfectN)
           pos=NodePosition(InfectN(j),t);
           PosN=0;
           for k=1:nodes
               PosN=NodePosition(k,t);
               if abs(pos-PosN)<=MinDistance
                    
                    if PNodes(k)<=B
                    InfectedNodes(k)=1;
                    end
               end
           end
           
        end
        t=t+1;

    end
    TotalInfect(i)=size(find(InfectedNodes),1);
end

[sortedValues,sortIndex] = sort(TotalInfect(:),'descend');
 Kset = sortIndex(1:K); 
 TotalOpt=sum(TotalInfect(Kset));




