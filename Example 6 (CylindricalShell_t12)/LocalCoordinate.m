function Localcoord = LocalCoordinate(xi,yi,zi,xj,yj,zj,xm,ym,zm)
%----------------------------------------------------------
% Calculation of local coordinates for triangular elements
%----------------------------------------------------------
delta1 = xj-xi; delta2 = yj-yi; delta3 = zj-zi;
delta4 = xm-xi; delta5 = ym-yi; delta6 = zm-zi;
a1     = [delta1; delta2; delta3];
a2     = [delta4; delta5; delta6];
e1     = 1 / sqrt(delta1^2 + delta2^2 + delta3^2) * a1;
e3     = cross(a1,a2) / norm(cross(a1,a2));
e2     = cross(e3,e1);
lamT   = [e1 e2 e3];
localx = [0;0;0];
localy = [sqrt(delta1*delta1 + delta2*delta2 + delta3*delta3);0;0];
localz = transpose(lamT) * a2;
Localcoord = [localx;localy;localz];






