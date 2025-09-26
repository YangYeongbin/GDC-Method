function kge = Geometricstiffnessmatrix2DB(Ma,Fx,Mb,A,Iz,L)
%----------------------------------------
% Geometricstiffness matrix for 2D beam
%----------------------------------------
kge = zeros(6,6);
g1  = Fx/L;
g2  = Ma/L;
g3  = Mb/L;
g4  = Iz*Fx/(L*A);

kge(1,1) = g1; kge(2,2) = 6*g1/5 + 12*g4/L/L; kge(3,3) = 2*g1*L*L/15 + 4*g4; kge(4,4) = g1; kge(5,5) = 6*g1/5 + 12*g4/L/L; kge(6,6)=  2*g1*L*L/15 + 4*g4;
kge(1,3) = -g2; kge(3,1) = -g2;
kge(1,4) = -g1; kge(4,1) = -g1;
kge(1,6) = -g3; kge(6,1) = -g3;
kge(2,3) = L*g1/10 + 6*g4/L; kge(3,2) = L*g1/10 + 6*g4/L;
kge(2,5) = -6*g1/5 - 12*g4/L/L; kge(5,2) = -6*g1/5 - 12*g4/L/L;
kge(2,6) = L*g1/10 + 6*g4/L; kge(6,2) = L*g1/10 + 6*g4/L;
kge(3,4) = g2; kge(4,3) = g2;
kge(3,5) = -L*g1/10 - 6*g4/L; kge(5,3) = -L*g1/10 - 6*g4/L;
kge(3,6) = -L*L*g1/30 + 2*g4; kge(6,3) = -L*L*g1/30 + 2*g4;
kge(4,6) = g3; kge(6,4) = g3;
kge(5,6) = -L*g1/10 - 6*g4/L; kge(6,5) = -L*g1/10 - 6*g4/L;
