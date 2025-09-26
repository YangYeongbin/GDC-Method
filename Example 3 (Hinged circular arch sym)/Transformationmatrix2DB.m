function T = Transformationmatrix2DB(X1,Y1,X2,Y2)
%----------------------------------------------------
% Coordinate transformation matrix for 2D problem
%----------------------------------------------------
L = sqrt((X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2));
l  = (X2 - X1) / L; m = (Y2 - Y1) / L;
T  = [l m 0 0 0 0;
     -m l 0 0 0 0;
      0 0 1 0 0 0;
      0 0 0 l m 0;
      0 0 0 -m l 0;
      0 0 0 0 0 1];
