function keb = TriangleElementBendingElasticStiffness(E,MU,t,xi,yi,xj,yj,xm,ym)
%-------------------------------------------------------
% The elastic stiffness matrix for the bending actions
%-------------------------------------------------------
ai = xj*ym - xm*yj;
aj = xm*yi - xi*ym;
am = xi*yj - xj*yi; 
DoubleAera = ai + aj + am;                                                 % Double the area
L = [1/2 1/2 0;
     0 1/2 1/2;
     1/2 0 1/2];                                                           % Barycentric coordinates
D = E * t^3 / 12 / (1 - MU^2) * [1 MU 0;
                                 MU 1 0;
                                 0 0 (1-MU)/2];
keb = zeros(9,9);
W = [1/6 1/6 1/6];
for i = 1 : length(W)
    B = StrainMatrix(L(i,:),xi,yi,xj,yj,xm,ym);
    keb = keb + W(i) * transpose(B) * D * B * abs(DoubleAera);
end






