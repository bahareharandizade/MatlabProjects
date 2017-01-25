function [NodePosition]=MovementRandomChange(NodePosition,NodeNumber,nodes,T,Time)
t=1;
split=fix(nodes/4);
split2=split-1;
nodes=nodes-1;
SelectedTime=randperm(T,Time);

while t<Time
        
        SelectedNode=randperm(nodes,NodeNumber);
        RandomMove=rand(length(SelectedNode),1);
        for h=1:NodeNumber
            if RandomMove(h)<=0.8
               
               switch fix(SelectedNode(h)/split)
                   case 0
                        NodePosition(SelectedNode(h),SelectedTime(t))=randi([1,split2]);
                   case 1
                        NodePosition(SelectedNode(h),SelectedTime(t))=randi([split,split+split2]);
                   case 2
                        NodePosition(SelectedNode(h),SelectedTime(t))=randi([2*split,(2*split)+split2]);
                   case 3
                        NodePosition(SelectedNode(h),SelectedTime(t))=randi([3*split,(3*split)+split2]);
               end
            else
               
                temp=randi([1,3]);
                CurPos= NodePosition(SelectedNode(h),t);
                switch  fix(CurPos/split)
                   case 0
                        switch temp
                            case 1
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([split,split+split2]);
                            case 2
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([2*split,(2*split)+split2]);
                            case 3
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([3*split,(3*split)+split2]);
                        end
                   case 1
                        switch temp
                            case 1
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([1,split2]);
                            case 2
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([2*split,(2*split)+split2]);
                            case 3
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([3*split,(3*split)+split2]);
                        end
                   case 2
                        switch temp
                            case 1
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([1,split2]);
                            case 2
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([split,split+split2]);
                            case 3
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([3*split,(3*split)+split2]);
                        end
                   case 3
                        switch temp
                            case 1
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([1,split2]);
                            case 2
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([split,split+split2]);
                            case 3
                                NodePosition(SelectedNode(h),SelectedTime(t))=randi([2*split,(2*split)+split2]);
                        end
               end
                
            end
        end
        t=t+1;
       
end
