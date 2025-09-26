function [ElemForce,ks,F] = InternalForceBlance(Struct_dof,Elem_num,Elem_Node_num,Node_update,ElemForce,dU,ComType,E,MU,t)
Predictor = ComType(1:2);
Corrector = ComType(3:4);
F  = zeros(Struct_dof,1);
ks = zeros(Struct_dof,Struct_dof);
for n = 1 : Elem_num
    Ni = Elem_Node_num(n,1); Nj = Elem_Node_num(n,2); Nm = Elem_Node_num(n,3);
    Localcoord = LocalCoordinate(Node_update(Ni,1), ...
        Node_update(Ni,2),Node_update(Ni,3),Node_update(Nj,1),Node_update(Nj,2), ...
        Node_update(Nj,3),Node_update(Nm,1),Node_update(Nm,2),Node_update(Nm,3));
    T     = TransformationmatrixTriangleElement(Node_update(Ni,1), ...
        Node_update(Ni,2),Node_update(Ni,3),Node_update(Nj,1),Node_update(Nj,2), ...
        Node_update(Nj,3),Node_update(Nm,1),Node_update(Nm,2),Node_update(Nm,3));
    ke     = ElasticmatrixTriangleElement(E,MU,t,Localcoord(1,1),Localcoord(2,1), ...
        Localcoord(4,1),Localcoord(5,1),Localcoord(7,1),Localcoord(8,1));
    k      = T' * ke * T;
    if ismember(Predictor, {'P1','P3'})
        kge    = GeometricStiffnessTriangleElement(ElemForce{n},Localcoord);
        kg     = T' * kge * T;
    end
    dU_e   = [dU(6*Ni - 5);
        dU(6*Ni - 4);
        dU(6*Ni - 3);
        dU(6*Ni - 2);
        dU(6*Ni - 1);
        dU(6*Ni);
        dU(6*Nj - 5);
        dU(6*Nj - 4);
        dU(6*Nj - 3);
        dU(6*Nj - 2);
        dU(6*Nj - 1);
        dU(6*Nj);
        dU(6*Nm - 5);
        dU(6*Nm - 4);
        dU(6*Nm - 3);
        dU(6*Nm - 2);
        dU(6*Nm - 1);
        dU(6*Nm)];
    switch Predictor
        case 'P1'; K = k + kg;
        case 'P2'; K = k;
        case 'P3'; K = k + kg;
        case 'P4'; K = k;
        otherwise; error('Invalid Combination');
    end
    ks = AssemblyTriangleElement(ks,K,Ni,Nj,Nm);
    ue = T * dU_e;
    switch Corrector
        case 'C1'; ElemForce{n} = ElemForce{n} + (ke + kg) * ue;
        case 'C2'; ElemForce{n} = ElemForce{n} + ke * ue;
        otherwise; error('Invalid Combination');
    end
    F_tem = T' * ElemForce{n};
    F     = FAssemblyTriangleshell(F,F_tem,Ni,Nj,Nm);
end