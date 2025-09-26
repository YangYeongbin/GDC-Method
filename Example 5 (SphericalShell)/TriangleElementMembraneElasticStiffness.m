function kem = TriangleElementMembraneElasticStiffness(E,MU,t,xi,yi,xj,yj,xm,ym)
%--------------------------------------------------------
% The elastic stiffness matrix for the membrane actions
%--------------------------------------------------------
ai = xj*ym - xm*yj;
aj = xm*yi - xi*ym;
am = xi*yj - xj*yi;
bi = yj - ym;
bj = ym - yi;
bm = yi - yj;
ci = -(xj-xm);
cj = -(xm-xi);
cm = -(xi-xj);
area = (ai + aj + am) / 2;
B = 1 / 2 / abs(area) * [bi 0 bj 0 bm 0
                         0 ci 0 cj 0 cm
                         ci bi cj bj cm bm];
D = E / (1 - MU*MU) * [ 1 MU 0;
                        MU 1 0;
                        0 0 (1-MU)/2];
kem = transpose(B) * D * B * t * abs(area);

