function [ks,Pj,R] =  ModifyGlobalMatrices(ks,Pj,R,freedof,fixdof)
%--------------------------------------------------------------------------
% Split into matrices associated to free dofs and fixed dofs respectively
%--------------------------------------------------------------------------
% K_free
ks(:,fixdof) = 0; ks(fixdof,:) = 0;
l = size(fixdof,1);
for i = 1:l
    ks(fixdof(i),fixdof(i)) = 1;
end
% F_free
Pj(freedof)  = Pj(freedof);
Pj(fixdof)   = 0;
R(freedof)  = R(freedof);
R(fixdof)   = 0;