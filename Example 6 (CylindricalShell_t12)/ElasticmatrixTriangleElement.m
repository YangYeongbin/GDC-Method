function ke = ElasticmatrixTriangleElement(E,MU,t,xi,yi,xj,yj,xm,ym)
%------------------------------------------------
% element stiffness matrix for trianglar element
%------------------------------------------------
kem = TriangleElementMembraneElasticStiffness(E,MU,t,xi,yi,xj,yj,xm,ym);
keb = TriangleElementBendingElasticStiffness(E,MU,t,xi,yi,xj,yj,xm,ym);
ke  = zeros(18,18);
for m = 1 : 3
    for n = 1 : 3
        kpmn = kem(2*m - 1 : 2*m,2*n - 1 : 2*n);
        kbmn = keb(3*m - 2 : 3*m,3*n - 2 : 3*n);
        kmn  = zeros(6,6);
        kmn(1:2,1:2) = kpmn;
        kmn(3:5,3:5) = kbmn;
        kmn(6,1) = 0;
        kmn(6,2) = 0;
        kmn(6,3) = 0;
        kmn(6,4) = 0;
        kmn(6,5) = 0;
        kmn(6,6) = 1000;                                                   % Preventing the Singularity of the Stiffness Matrix
        kmn(1,6) = 0;
        kmn(2,6) = 0;
        kmn(3,6) = 0;
        kmn(4,6) = 0;
        kmn(5,6) = 0;
        ke(6*m - 5 : 6*m,6*n - 5 : 6*n) = kmn;
    end
end