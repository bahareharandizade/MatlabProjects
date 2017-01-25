function Total=Heuristic(NodePosition,Kset,T,B,nodes,PNodes)
MinDistance=3;
TotalInfect=zeros(length(Kset),1);
nodes=nodes-1;
for i=1:length(Kset)
    t=1;
    InfectedNodes=zeros(nodes,1);
    InfectedNodes(Kset(i))=1;
    
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
Total=sum(TotalInfect,1);
