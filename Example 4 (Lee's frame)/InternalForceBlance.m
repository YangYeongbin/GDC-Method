function [ElemForce,ks,F,L1] = InternalForceBlance(Struct_dof,Elem_num,Ele_Node_num,Node_update,E,A,ElemForce,L1,dU,ComType,Iz)
Predictor = ComType(1:2);
Corrector = ComType(3:4);
F  = zeros(Struct_dof,1);
L2 = zeros(Elem_num,1);
ks = zeros(Struct_dof,Struct_dof);
for n = 1 : 1 : Elem_num
    Ni     = Ele_Node_num(n,1);
    Nj     = Ele_Node_num(n,2);
    L2(n)  = ElementLength2DB(Node_update(Ni,1),Node_update(Ni,2), ...
        Node_update(Nj,1),Node_update(Nj,2));
    T      = Transformationmatrix2DB(Node_update(Ni,1),Node_update(Ni,2), ...
        Node_update(Nj,1),Node_update(Nj,2));
    fe_num = ElemForce{n};
    Fxb=fe_num(4);
    Mza=fe_num(3);
    Mzb=fe_num(6);
    ke     = Elasticmatrix2DB(E,A,L2(n),Iz);
    k      = T' * ke * T;
    if ismember(Predictor, {'P1','P3'})
        kge    = Geometricstiffnessmatrix2DB(Mza,Fxb,Mzb,A,Iz,L2(n));
        kg     = T' * kge * T;
    end
    dU_e   = [dU(3 * Ni - 2);
              dU(3 * Ni - 1);
              dU(3 * Ni);
              dU(3 * Nj - 2);
              dU(3 * Nj - 1);
              dU(3 * Nj)];
    switch Predictor
        case 'P1'; K = k + kg;
        case 'P2'; K = k;
        case 'P3'; K = k + kg;
        case 'P4'; K = k;
        otherwise; error('Invalid Combination');
    end
    ks = Assembly2DB(ks,K,Ni,Nj);
    ue = T * dU_e;
    switch Corrector
        case 'C1'; ElemForce{n} = ElemForce{n} + (ke + kg) * ue;
        case 'C2'; ElemForce{n} = ElemForce{n} + ke * ue;
        otherwise; error('Invalid Combination');
    end
    L1(n) = L2(n);
    F_tem = T' * ElemForce{n};
    F     = FAssembly2DB(F,F_tem,Ni,Nj);
end   