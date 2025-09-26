function F = FAssemblyTriangleshell(F,F_tem,i,j,m)
F(6*i-5:6*i) = F(6*i-5:6*i) + F_tem(1:6);
F(6*j-5:6*j) = F(6*j-5:6*j) + F_tem(7:12);
F(6*m-5:6*m) = F(6*m-5:6*m) + F_tem(13:18);