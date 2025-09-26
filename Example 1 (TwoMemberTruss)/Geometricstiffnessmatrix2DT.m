function kge = Geometricstiffnessmatrix2DT(Fx,L)
%----------------------------------------
% Geometricstiffness matrix for 2D truss
%----------------------------------------
kge = Fx/L * [1 0 -1 0;
              0 1 0 -1;
             -1 0 1 0;
              0 -1 0 1];
