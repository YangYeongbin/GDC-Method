function result = SolutionProcess(ComType)
%--------------------------------------------------------------------------
% Deep arh's frame problem
%--------------------------------------------------------------------------
clc;
% Timer
tic;
%% Problem definition
% geometric data
A             = 1;
Iz            = 1;
% material data
E             = 2000;
% Coordinate calculation
Node_coor     = [-50	0
                 -49.605735	6.266662
                 -48.429158	12.434494
                 -46.488824	18.406227
                 -43.845334	24.03303
                 -40.450849	29.389262
                 -36.448431	34.227355
                 -31.871199	38.525662
                 -26.791339	42.216396
                 -21.288965	45.241352
                 -15.450849	47.552825
                 -9.369066	49.114362
                 -3.139526	49.901336
                 0	50
                 3.139526	49.901336
                 9.369066	49.114362
                 15.450849	47.552825
                 21.288965	45.241352
                 26.791339	42.216396
                 31.871199	38.525662
                 36.448431	34.227355
                 40.450849	29.389262
                 43.845334	24.03303
                 46.488824	18.406227
                 48.429158	12.434494
                 49.605735	6.266662
                 50	0];
% LoadParameter
lamda_initial = 0.01;
%% Mesh
Elem_num   = 26;
Node_num   = 27;
Node_dof   = 3;
Struct_dof = Node_dof * Node_num;
%% Initialization
i = 1;
Elem_Node_num = zeros(Elem_num,2);
for n=1:Elem_num
    Elem_Node_num(n,1) = n;
    Elem_Node_num(n,2) = n + 1;
end
U         = zeros(Struct_dof,1);
R         = zeros(Struct_dof,1);
R_temp    = zeros(Struct_dof,1);
dU        = zeros(Struct_dof,1);
ElemForce = cell(Elem_num,1);
fe_num    = zeros(6,1);
result    = {};
lamda_sum = 0;
dU_sum    = zeros(Struct_dof,1);
for node = 1 : Elem_num
    ElemForce{node} = zeros(6,1);
end
% pre-allocating memory
Fy      = zeros(8000,1);
Uy      = zeros(8000,1);
GSP_sum = zeros(8000,1);
Iter    = zeros(8000,1);
%% Boundary conditions and nodal forces
% fixed dofs
% BCtype = 1
inf_bc           = [[1   1 1 0]
                    [27   1 1 0]];
inf_nf           = [[14   0 -1 0]];
[freedof,fixdof] = FindFixedDof(inf_bc,Struct_dof,Node_dof);
% Nodal forces
[Pj,F,P]         = BuildForceVector(inf_nf,Struct_dof);
% Nodal coordinal
Node_update = Node_coor;
%--------------------------------------------------------------------------
% Iterative solver
%--------------------------------------------------------------------------
while F(41) >= -220
    j           = 1;
    R(:,:)      = 0;
    R_temp(:,:) = 0;
    R_temp(1)   = 1e10;
    % the displacement increment and lamda at the previous increment
    dlamda      = lamda_sum;
    dU_last     = dU_sum;
    lamda_sum   = 0;
    dU_sum      = zeros(Struct_dof,1);
    %% Error checking phase
    while norm(R_temp) >= (0.0001 * norm(Pj*lamda_sum)) % Pj*lamda_sum
        %% Predictor phase
        % Establishing geometric and elastic stiffness initial; and
        % for i > 1 and j > 1, stiffness matrix will inherit the last
        % iteration
        if (i == 1) && (j == 1)
            [ks,L1]    = BuildGlobalMatrices(Struct_dof,Elem_num,Elem_Node_num,Node_update,E,A,Iz);
            [ks,F,R]   = ModifyGlobalMatrices(ks,F,R,freedof,fixdof);
        end        
        % embedded secant predictor
        Predictor = ComType(1:2);
        if strcmp(Predictor,'P1') && (i > 1) && (j == 1)
            Up = dU_last / dlamda;
            Ur = 0;
        else
            Up = ks \ Pj;
            Ur = ks \ R;
        end
        % Generalized displacement control method
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
        %% Corrector Phase
        % Update Coordinates
        [Node_update] = UpdateCoordinates(Node_update,Node_num,dU);
        % Element force recovery procedure
        [ElemForce,ks,F,L1] = InternalForceBlance(Struct_dof,Elem_num,Elem_Node_num,Node_update,E,A,ElemForce,L1,dU,ComType,Iz);
        % Update resulting nodal forces and displacement
        U            = U + dU;
        P            = P + lamda * Pj;
        lamda_sum    = lamda_sum + lamda;
        dU_sum       = dU_sum + dU;
        % unblance force
        R            = P - F;
        [ks,F,R]     = ModifyGlobalMatrices(ks,F,R,freedof,fixdof);
        R_temp       = R;
        j = j + 1;
        %% Data output
        Fy(i)  = -F(41);
        Uy(i)  = -U(41);
        GSP_sum(i) = GSP;
    end
    % the number of increment/iteration
    Iter(i) = j - 1;
    i = i + 1;
end
toc
%% Computational efficiency
% Resize the array to remove extra preallocated elements
Fy = Fy(1 : i - 1); Uy = Uy(1 : i - 1); 
GSP_sum = GSP_sum(1 : i - 1);
Iter = Iter(1 : i - 1);
% exports
result{1}  = Fy; result{2} = Uy; 
result{3}  = GSP_sum;
result{4}  = [i,sum(Iter(:)),sum(Iter(:)) / i,toc];
  