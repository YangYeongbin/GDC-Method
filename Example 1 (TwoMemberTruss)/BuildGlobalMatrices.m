function [ks,L1,L0] = BuildGlobalMatrices(Node_num,Elem_num,Ele_Node_num,Node_update,E,A)
L0 = zeros(Elem_num,1);
L1 = zeros(Elem_num,1);
ks = zeros(2*Node_num,2*Node_num);
for n     = 1:1:Elem_num
    Ni    = Ele_Node_num(n,1);Nj=Ele_Node_num(n,2);
    L0(n) = ElementLength2DT(Node_update(Ni,1),Node_update(Ni,2),Node_update(Nj,1), ...
        Node_update(Nj,2));
    L1(n) = L0(n);
    T     = Transformationmatrix2DT(Node_update(Ni,1),Node_update(Ni,2),Node_update(Nj,1), ...
        Node_update(Nj,2));
    ke    = Elasticmatrix2DT(E,A,L1(n));
    K     = T'*ke*T;
    ks    = Assembly2DT(ks,K,Ni,Nj);
end