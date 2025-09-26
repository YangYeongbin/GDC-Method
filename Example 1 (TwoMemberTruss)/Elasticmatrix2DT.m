function ke = Elasticmatrix2DT(E,A,L)
%---------------------------------------
% element stiffness matrix for 2D-truss
%---------------------------------------
ke = (E * A / L) * [1 0 -1 0;
                    0 0 0 0;
                    -1 0 1 0;
                    0 0 0 0];