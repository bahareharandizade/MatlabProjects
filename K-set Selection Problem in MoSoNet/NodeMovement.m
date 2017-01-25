function [NodePosition]=NodeMovement(T,nodes)
split=fix(nodes/4);
split2=split-1;
NodePosition=zeros(nodes-1,T);
t=1;
for i=1:nodes-1
     switch fix(i/split)
                case 0
                    NodePosition(i,t)=randi([1,split2]);
                case 1
                    NodePosition(i,t)=randi([split,split+split2]);
                case 2
                    NodePosition(i,t)=randi([2*split,(2*split)+split2]);
                case 3
                    NodePosition(i,t)=randi([3*split,(3*split)+split2]);
                    
     end 
end
t=t+1;
while t<T
        
        
        RandomMove=rand(nodes,1);
        for h=1:nodes-1
            if RandomMove(h)<=0.8
               
               switch fix(h/split)
                   case 0
                        NodePosition(h,t)=randi([1,split2]);
                   case 1
                        NodePosition(h,t)=randi([split,split+split2]);
                   case 2
                        NodePosition(h,t)=randi([2*split,(2*split)+split2]);
                   case 3
                        NodePosition(h,t)=randi([3*split,(3*split)+split2]);
               end
            else
               
                temp=randi([1,3]);
                CurPos= NodePosition(h,t);
                switch  fix(CurPos/split)
                   case 0
                        switch temp
                            case 1
                                NodePosition(h,t)=randi([split,split+split2]);
                            case 2
                                NodePosition(h,t)=randi([2*split,(2*split)+split2]);
                            case 3
                                NodePosition(h,t)=randi([3*split,(3*split)+split2]);
                        end
                   case 1
                        switch temp
                            case 1
                                NodePosition(h,t)=randi([1,split2]);
                            case 2
                                NodePosition(h,t)=randi([2*split,(2*split)+split2]);
                            case 3
                                NodePosition(h,t)=randi([3*split,(3*split)+split2]);
                        end
                   case 2
                        switch temp
                            case 1
                                NodePosition(h,t)=randi([1,split2]);
                            case 2
                                NodePosition(h,t)=randi([split,split+split2]);
                            case 3
                                NodePosition(h,t)=randi([3*split,(3*split)+split2]);
                        end
                   case 3
                        switch temp
                            case 1
                                NodePosition(h,t)=randi([1,split2]);
                            case 2
                                NodePosition(h,t)=randi([split,split+split2]);
                            case 3
                                NodePosition(h,t)=randi([2*split,(2*split)+split2]);
                        end
               end
                
            end
        end
        t=t+1;
       
end

