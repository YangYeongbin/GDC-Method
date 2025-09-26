function [freedof,fixdof] = FindFixedDof(data_bc,Node_dof,dof)
%--------------------------------------------------------------------------
% Obtain fixed and free dof
%--------------------------------------------------------------------------
%% initalization
freedof = (1:Node_dof)';
fixdof  = zeros(Node_dof,1);
%% loop over nodes with fixed dofs
for ii = 1 : size(data_bc,1)
    node = data_bc(ii,1);
    fixdof((node-1)*dof+(1:dof)) = data_bc(ii,2:end);
end
%% Assemble fixed and free dof sequences
fixdof  = fixdof.*freedof;
fixdof  = fixdof(fixdof>0);
freedof(fixdof) = [ ];
end