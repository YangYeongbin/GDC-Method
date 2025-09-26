function y=ExternalGeometricstiffnessmatrix2DT(Fx,L)
K=Fx/L*[1 0 -1 0;
        0 1 0 -1;
        -1 0 1 0;
        0 -1 0 1];
y=K;
