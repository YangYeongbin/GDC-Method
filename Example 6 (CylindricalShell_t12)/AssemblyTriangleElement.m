function K = AssemblyTriangleElement(K, k, i, j, m)
%---------------------------------------------------------
% Assembly Total stiffness matrix for triangle element
%---------------------------------------------------------
DOF = zeros(18,1);
DOF(1)  = 6*i - 5; DOF(2)  = 6*i - 4; DOF(3)  = 6*i - 3;
DOF(4)  = 6*i - 2; DOF(5)  = 6*i - 1; DOF(6)  = 6*i;
DOF(7)  = 6*j - 5; DOF(8)  = 6*j - 4; DOF(9)  = 6*j - 3;
DOF(10) = 6*j - 2; DOF(11) = 6*j - 1; DOF(12) = 6*j;
DOF(13) = 6*m - 5; DOF(14) = 6*m - 4; DOF(15) = 6*m - 3;
DOF(16) = 6*m - 2; DOF(17) = 6*m - 1; DOF(18) = 6*m;
for n1 = 1:18
   for n2 = 1:18
         K(DOF(n1),DOF(n2)) = K(DOF(n1),DOF(n2)) + k(n1,n2);
   end
end