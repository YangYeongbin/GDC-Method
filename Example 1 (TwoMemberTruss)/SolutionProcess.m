function result = SolutionProcess(ComType)
%--------------------------------------------------------------------------
% Two-Member problem
%--------------------------------------------------------------------------
clc;
% Timer
tic;
%% Problem definition
% geometric data
A             = 1;
% material data
E             = 1884.694;
% Coordinate calculation
Node_coor     = [0	0
                12.943	25.847
                25.886	0];
% LoadParameter
lamda_initial = 1;
%% Mesh
Elem_num   = 2;
Node_num   = 3;
Node_dof   = 2;
Struct_dof = Node_dof * Node_num;
ID         = reshape((1:Struct_dof),Elem_num,[]);
%% Initialization
i = 1;j = 1;
Elem_Node_num = zeros(Elem_num,2);
for node = 1:1:Elem_num
    Elem_Node_num(node,1) = node;
    Elem_Node_num(node,2) = node + 1;
end
U         = zeros(Struct_dof,1);
R         = zeros(Struct_dof,1);
R_temp    = zeros(Struct_dof,1);
dU        = zeros(Struct_dof,1);
ElemForce = cell(Elem_num,1);
fe_num    = zeros(4,1);
result    = {};
lamda_sum = 0;
dU_sum    = zeros(Struct_dof,1);
for node = 1:1:Elem_num
    ElemForce{node} = zeros(4,1);
end
% pre-allocating memory
F_y     = zeros(5000,1);
U_x     = zeros(5000,1);
U_y     = zeros(5000,1);
GSP_sum = zeros(5000,1);
Iter    = zeros(5000,1);
%% Boundary conditions and nodal forces
% fixed dofs
% BCtype = 1
inf_bc           = [[1   1 1]
                    [3   1 1]];
inf_nf           = [[2   0.5 -10]];
[freedof,fixdof] = FindFixedDof(inf_bc,Struct_dof,Node_dof);
% Nodal forces
[Pj,F,P]         = BuildForceVector(inf_nf,Struct_dof);
% Nodal coordinal
Node_update = Node_coor;
%--------------------------------------------------------------------------
% Iterative solver
%--------------------------------------------------------------------------
while U(4) >= -54
    j           = 1;
    R(:,:)      = 0;
    R_temp(:,:) = 0;
    R_temp(1)   = 1e10;
    % the displacement increment and lamda at the previous increment
    dlamda      = lamda_sum;
    dU_last     = dU_sum;
    lamda_sum   = 0;
    dU_sum      = zeros(Struct_dof,1);
    % Fint1       = F;
    %% Error checking phase
    while norm(R_temp) >= (0.0001 * norm(Pj*lamda_sum)) % Pj*lamda_sum
        %% Predictor phase
        % Establishing geometric and elastic stiffness initial
        if (i == 1) && (j == 1)
            [ks,L1,L0] = BuildGlobalMatrices(Node_num,Elem_num,Elem_Node_num,Node_update,E,A);
            [ks,Pj,R]  = ModifyGlobalMatrices(ks,Pj,R,freedof,fixdof);
        end
        % incrementally secant predictor
        Predictor = ComType(1:2);
        if strcmp(Predictor,'P1') && (i > 1) && (j == 1)
            Up = dU_last / dlamda;
            Ur = 0;
        else
            Up = ks \ Pj;
            Ur = ks \ R;
        end
        %% Generalized displacement control method
        if (j == 1)
            if (i == 1)
                lamda_last = lamda_initial;
                Up_first   = Up;
                Up_initial = Up_first;
                GSP        = 1;
            end
            [Up_lastFirst,Up_first] = VariableUpdate(Up_first,Up);
        end
        [GSP,lamda,lamda_last,Up_first,dU] = LoadParameter(Up,Ur,i,j,Up_lastFirst,lamda_last,Up_initial,Up_first,GSP,lamda_initial);
        if j==1
            detK(i,:) = [i lamda * (Up_first' * Up_first) * det(ks) det(ks)];
        end
        %% Corrector Phase
        % Update Coordinates
        [Node_update] = UpdateCoordinates(Node_update,Node_num,dU);
        % Element force recovery procedure
        [ElemForce,ks,F,L1] = InternalForceBlance(Struct_dof,Elem_num,Elem_Node_num,Node_update,E,A,ElemForce,L1,L0,dU,ComType);
        % Update resulting nodal forces and displacement
        U            = U + dU;
        P            = P + lamda * Pj;
        lamda_sum    = lamda_sum + lamda;
        dU_sum       = dU_sum + dU;
        % unblance force
        R            = P - F;
        [ks,Pj,R]    = ModifyGlobalMatrices(ks,Pj,R,freedof,fixdof);
        R_temp       = R;
        U1           = dU;
        j = j + 1;
        %% Data output
        F_y(i)  = -F(4);
        U_x(i)  = U(3);
        U_y(i)  = -U(4);
        GSP_sum(i) = GSP;
    end
    % the number of increment/iteration
    Iter(i) = j - 1;
    i = i + 1;
end
toc
%% Computational efficiency
% Resize the array to remove extra preallocated elements
F_y = F_y(1 : i - 1); U_x = U_x(1 : i - 1); 
U_y = U_y(1 : i - 1); GSP_sum = GSP_sum(1 : i - 1);
Iter = Iter(1 : i - 1);
% exports
result{1}  = F_y; result{2} = U_x; 
result{3}  = U_y; result{4} = GSP_sum;
result{5}  = [i,sum(Iter(:)),sum(Iter(:)) / i,toc];
result{6}  = detK;
  