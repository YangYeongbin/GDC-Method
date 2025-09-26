function [Pj,F,P] = BuildForceVector(inf_nf,Node_dof)
%--------------------------------------------------------------------------
% Build Force Vector due to nodal forces
%--------------------------------------------------------------------------
Pj = zeros(Node_dof,1);
P  = zeros(Node_dof,1);
F  = zeros(Node_dof,1);
nnf = size(inf_nf,1);
for inf = 1 : nnf
    np                  = inf_nf(inf,1);
    force               = inf_nf(inf,2:end);
    Pj(3*np - 2 : 3*np) = force;
end
end