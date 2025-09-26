function ke = Elasticmatrix2DB(E,A,L,Iz)
%---------------------------------------
% element stiffness matrix for 2D-beam
%---------------------------------------
w1 = E*A/L;
w2 = 12*E*Iz/(L*L*L);
w3 = 6*E*Iz/(L*L);
w4 = 4*E*Iz/L;
w5 = 2*E*Iz/L;

ke = zeros(6,6);
ke(1,1) = w1; ke(1,4) = -w1;
ke(2,2) = w2; ke(2,3) = w3;ke(2,5) = -w2; ke(2,6) = w3;
ke(3,2) = w3; ke(3,3) = w4; ke(3,5) = -w3; ke(3,6) = w5;
ke(4,1) = ke(1,4); ke(4,4) = w1;
ke(5,2) = ke(2,5); ke(5,3) = ke(3,5); ke(5,5) = w2; ke(5,6) = -w3;
ke(6,2) = ke(2,6); ke(6,3) = ke(3,6); ke(6,5) = ke(5,6); ke(6,6) = w4;
