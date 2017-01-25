function DegreeNode=SocialNetGraph(nodes,MaxAdj)

CSVFile=[];
split=fix(nodes/4);
split2=split-1;
DegreeNode=zeros(nodes,1);
for i=1:nodes-1
    t=randi([1,MaxAdj]);
    DegreeNode(i)=t;
    for g=1:t
        r=rand;
        if r <=0.8
              switch fix(i/split)
                case 0
                    temp=randi([1,split2]);
                    CSVFile=[CSVFile;i temp];
                case 1
                    temp=randi([split,split+split2]);
                    CSVFile=[CSVFile;i temp];
                case 2
                    temp=randi([2*split,(2*split)+split2]);
                    CSVFile=[CSVFile;i temp];
                case 3
                    temp=randi([3*split,(3*split)+split2]);
                    CSVFile=[CSVFile;i temp];
                    
              end
        else
             temp=randi([1,3]);
              switch fix(i/split)
               
                case 0
                    temp=randi([split,(3*split)+split2]);
                    CSVFile=[CSVFile;i randi([split,(3*split)+split2])];
                case 1
                    switch temp
                            case 1
                                temp=randi([1,split2]);
                                CSVFile=[CSVFile;i temp];
                            case 2
                                temp=randi([2*split,(2*split)+split2]);
                                CSVFile=[CSVFile;i temp];
                            case 3
                                temp=randi([3*split,(3*split)+split2]);
                                CSVFile=[CSVFile;i temp];
                     end
                case 2
                    switch temp
                            case 1
                                temp=randi([1,split2]);
                                CSVFile=[CSVFile;i temp];
                            case 2
                                temp=randi([split,split+split2]);
                                CSVFile=[CSVFile;i temp];
                            case 3
                                temp=randi([3*split,(3*split)+split2]);
                                CSVFile=[CSVFile;i temp];
                    end
                    
                case 3
                    switch temp
                            case 1
                                temp=randi([1,split2]);
                                CSVFile=[CSVFile;i temp];
                            case 2
                                temp=randi([split,split+split2]);
                                CSVFile=[CSVFile;i temp];
                            case 3
                                temp=randi([2*split,(2*split)+split2]);
                                CSVFile=[CSVFile;i temp];
                    end
                    
                    
              end
            
        end
        
    end
end

csvwrite('SocialGraph.csv',CSVFile);

