function F = FAssembly2DB(F,F_tem,p,m)
DOF(1) = 3*p - 2;
DOF(2) = 3*p - 1;
DOF(3) = 3*p;
DOF(4) = 3*m - 2;
DOF(5) = 3*m - 1;
DOF(6) = 3*m;
for n1 = 1:6
        F(DOF(n1)) = F(DOF(n1)) + F_tem(n1);
end