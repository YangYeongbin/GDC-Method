function [Pj,F,P] = BuildForceVector(inf_nf,ngdof)
%--------------------------------------------------------------------------
% Build Force Vector due to nodal forces
%--------------------------------------------------------------------------
Pj = zeros(ngdof,1);
P  = zeros(ngdof,1);
F  = zeros(ngdof,1);
nnf = size(inf_nf,1);
for inf = 1 : nnf
    np                  = inf_nf(inf,1);
    force               = inf_nf(inf,2:end);
    Pj(2*np - 1 : 2*np) = force;
end
end