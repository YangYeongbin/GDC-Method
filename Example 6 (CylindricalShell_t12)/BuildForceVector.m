function [Pj,F,P] = BuildForceVector(inf_nf,Struct_dof)
%--------------------------------------------------------------------------
% Build Force Vector due to nodal forces
%--------------------------------------------------------------------------
Pj = zeros(Struct_dof,1);
P  = zeros(Struct_dof,1);
F  = zeros(Struct_dof,1);
nnf = size(inf_nf,1);
for inf = 1 : nnf
    np                  = inf_nf(inf,1);
    force               = inf_nf(inf,2:end);
    Pj(6*np - 5 : 6*np) = force;
end
end