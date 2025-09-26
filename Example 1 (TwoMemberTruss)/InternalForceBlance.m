function [ElemForce,ks,F,L1] = InternalForceBlance(Node_dof,Elem_num,Ele_Node_num,Node_update,E,A,ElemForce,L1,L0,dU,ComType)
Predictor = ComType(1:2);
Corrector = ComType(3:4);
F  = zeros(Node_dof,1);
L2 = zeros(Elem_num,1);
ks = zeros(Node_dof,Node_dof);
for n = 1 : 1 : Elem_num
    Ni     = Ele_Node_num(n,1);
    Nj     = Ele_Node_num(n,2);
    L2(n)  = ElementLength2DT(Node_update(Ni,1),Node_update(Ni,2),Node_update(Nj,1),Node_update(Nj,2));
    T      = Transformationmatrix2DT(Node_update(Ni,1),Node_update(Ni,2),Node_update(Nj,1),Node_update(Nj,2));
    % E_eq: elastic modular considering volume changes
    E_eq   = E * (L2(n) / L0(n)) ^ 3;
    fe_num = ElemForce{n};
    Fx     = fe_num(3);
    ke     = Elasticmatrix2DT(E_eq,A,L2(n));
    k      = T' * ke * T;
    kge    = Geometricstiffnessmatrix2DT(Fx,L2(n));
    kg     = T' * kge * T;
    dU_e   = [dU(2 * Ni - 1);
              dU(2 * Ni);
              dU(2 * Nj - 1);
              dU(2 * Nj)];
    switch Predictor
        case 'P1'; K = k + kg;
        case 'P2'; K = k;
        case 'P3'; K = k + kg;
        case 'P4'; K = k;
        otherwise; error('Invalid Combination');
    end
    ks = Assembly2DT(ks,K,Ni,Nj);
    ue = T * dU_e;
    switch Corrector
        case 'C1'; ElemForce{n} = (ElemForce{n} + ke * ue) * L2(n) / L1(n);
        case 'C2'; ElemForce{n} = ElemForce{n} + (ke + kg) * ue;
        otherwise; error('Invalid Combination');
    end
    L1(n) = L2(n);
    F_tem = T' * ElemForce{n};
    F     = FAssembly2DT(F,F_tem,Ni,Nj);
end   