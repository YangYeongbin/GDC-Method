function ks = Assembly2DT(K,k,Ni,Nj)
%----------------------------------------------
% Assembly Total stiffness matrix for 2D truss
%----------------------------------------------
DOF(1) = 2 * Ni-1;
DOF(2) = 2 * Ni;
DOF(3) = 2 * Nj-1;
DOF(4) = 2 * Nj;
for m = 1 : 4
    for n = 1 : 4
        K(DOF(m),DOF(n)) = K(DOF(m),DOF(n)) + k(m,n);
    end
end
ks = K;