function T = TransformationmatrixTriangleElement(xi,yi,zi,xj,yj,zj,xm,ym,zm)
%----------------------------------------------------
% Coordinate transformation matrix for triangle element
%----------------------------------------------------
T      = zeros(18,18);
R      = zeros(6,6);
delta1 = xj-xi; delta2 = yj-yi; delta3 = zj-zi;
delta4 = xm-xi; delta5 = ym-yi; delta6 = zm-zi;
a1     = [delta1; delta2; delta3];
a2     = [delta4; delta5; delta6];
e1     = 1 / sqrt(delta1^2 + delta2^2 + delta3^2) * a1;
e3     = cross(a1,a2) / norm(cross(a1,a2));
e2     = cross(e3,e1);
lamT   = [e1 e2 e3];
lam    = transpose(lamT);
R(1:3,1:3)     = lam;
R(4:6,4:6)     = lam;
T(1:6,1:6)     = R;
T(7:12,7:12)   = R;
T(13:18,13:18) = R;
