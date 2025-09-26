function y=FAssembly2DT(F,F_tem,p,m)
%%组装总刚
%%曾攀有限元基础教程P44
DOF(1)=2*p-1;
DOF(2)=2*p;
DOF(3)=2*m-1;
DOF(4)=2*m;
for n1=1:4
        F(DOF(n1))=F(DOF(n1))+F_tem(n1);
end
y=F;