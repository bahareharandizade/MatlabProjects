function Demo()
T=20;
nodes=2000;
k=80;
Region=4;
KR=fix(k/Region);
d=fix(nodes/4);
d1=d-1;
MaxAdj=10;
B=0.05;
PNodes=rand(nodes,1);
DegreeNodes=SocialNetGraph(nodes,MaxAdj);
kC=[];
TotalHeuristic=[];
TotalSocial=[];
TotalRandom=[];
i=1;
for k=4:4:160
KR=fix(k/Region); 
n1=randi([1,d1],KR,1);
n2=randi([d,d1+d],KR,1);
n3=randi([2*d,(2*d)+d1],KR,1);
n4=randi([3*d,(3*d)+d1],KR,1);
KsetS=[n1 n2 n3 n4];
NodePosition=NodeMovement(T,nodes);
[KSet,TotalOpt(i)]=KSetSelection(nodes,NodePosition,T,B,k,PNodes);
NodePosition1=MovementRandomChange(NodePosition,1000,nodes,T,15);
TotalHeuristic(i)=Heuristic(NodePosition1,KSet,T,B,nodes,PNodes);
TotalSocial(i)=Heuristic(NodePosition1,KsetS,T,B,nodes,PNodes);
TotalRandom(i)=Random(NodePosition1,k,T,B,nodes,PNodes);
kC(i)=k;
i=i+1;

end
plot(TotalOpt,kC,'-.or',TotalHeuristic,kC,'-.ob',TotalSocial,kC,'-.og',TotalRandom,kC,'-.om');
% KR=fix(k/Region); 
% n1=randi([1,d1],KR,1);
% n2=randi([d,d1+d],KR,1);
% n3=randi([2*d,(2*d)+d1],KR,1);
% n4=randi([3*d,(3*d)+d1],KR,1);
% KsetS=[n1 n2 n3 n4];
% for B=0.01:0.01:0.5
% 
% NodePosition=NodeMovement(T,nodes);
% [KSet,TotalOpt(i)]=KSetSelection(nodes,NodePosition,T,B,k,PNodes);
% NodePosition1=MovementRandomChange(NodePosition,120,nodes,T,8);
% TotalHeuristic(i)=Heuristic(NodePosition1,KSet,T,B,nodes,PNodes);
% TotalSocial(i)=Heuristic(NodePosition1,KsetS,T,B,nodes,PNodes);
% TotalRandom(i)=Random(NodePosition1,k,T,B,nodes,PNodes);
% kC(i)=B;
% i=i+1;
% 
% end
% plot(TotalOpt,kC,'-.or',TotalHeuristic,kC,'-.ob',TotalSocial,kC,'-.og',TotalRandom,kC,'-.om');
KR=fix(k/Region); 
% for nodes=1000:500:5000
% d=fix(nodes/4);
% d1=d-1;
% PNodes=rand(nodes,1);
% 
% n1=randi([1,d1],KR,1);
% n2=randi([d,d1+d],KR,1);
% n3=randi([2*d,(2*d)+d1],KR,1);
% n4=randi([3*d,(3*d)+d1],KR,1);
% KsetS=[n1 n2 n3 n4];
% NodePosition=NodeMovement(T,nodes);
% [KSet,TotalOpt(i)]=KSetSelection(nodes,NodePosition,T,B,k,PNodes);
% NodePosition1=MovementRandomChange(NodePosition,120,nodes,T,8);
% TotalHeuristic(i)=Heuristic(NodePosition1,KSet,T,B,nodes,PNodes);
% TotalSocial(i)=Heuristic(NodePosition1,KsetS,T,B,nodes,PNodes);
% TotalRandom(i)=Random(NodePosition1,k,T,B,nodes,PNodes);
% kC(i)=nodes;
% i=i+1;
% 
% end
% plot(TotalOpt,kC,'-.or',TotalHeuristic,kC,'-.ob',TotalSocial,kC,'-.og',TotalRandom,kC,'-.om');





