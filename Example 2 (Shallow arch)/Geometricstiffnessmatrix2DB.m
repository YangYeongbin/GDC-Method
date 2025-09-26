function kge = Geometricstiffnessmatrix2DB(Fx,Fy,L)
%----------------------------------------
% Geometricstiffness matrix for 2D beam
%----------------------------------------
kge=zeros(6,6);
w1=Fx/L;
w2=Fy/L;

kge(1,2)=-w2;kge(1,5)=w2;
kge(2,1)=-w2;kge(2,2)=w1;kge(2,4)=w2;kge(2,5)=-w1;

kge(4,2)=w2;kge(4,5)=-w2;
kge(5,1)=w2;kge(5,2)=-w1;kge(5,4)=-w2;kge(5,5)=w1;

