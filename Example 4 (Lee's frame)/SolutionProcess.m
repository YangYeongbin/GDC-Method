function result = SolutionProcess(ComType)
%--------------------------------------------------------------------------
% Lee's frame problem
%--------------------------------------------------------------------------
% clc;
% Timer
total_time = tic;
%% Problem definition
% geometric data
A             = 6 * 10^-4;
Iz            = 2 * 10^-8;
% material data
E             = 7.2 * 10^9;
% Coordinate calculation
Node_coor     = [0 0
                 0 -0.24
                 0 -0.48
                 0 -0.72
                 0 -0.96
                 0 -1.2
                 0.24 -1.2
                 0.48 -1.2
                 0.72 -1.2
                 0.96 -1.2
                 1.2 -1.2];
% LoadParameter
lamda_initial = 1;
%% Mesh
Elem_num   = 10;
Node_num   = 11;
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
for node = 1:1:Elem_num
    ElemForce{node} = zeros(6,1);
end
% pre-allocating memory
Fy      = zeros(5000,1);
Uy      = zeros(5000,1);
GSP_sum = zeros(5000,1);
Iter    = zeros(5000,1);
iter1_time = zeros(5000,1);
%% Boundary conditions and nodal forces
% fixed dofs
% BCtype = 1
inf_bc           = [[1   1 1 0]
                    [11   1 1 0]];
inf_nf           = [[7   0 80 0]];
[freedof,fixdof] = FindFixedDof(inf_bc,Struct_dof,Node_dof);
% Nodal forces
[Pj,F,P]         = BuildForceVector(inf_nf,Struct_dof);
% Nodal coordinal
Node_update = Node_coor;
%--------------------------------------------------------------------------
% Iterative solver
%--------------------------------------------------------------------------
while F(20) < 2000
    j           = 1;
    R(:,:)      = 0;
    R_temp(:,:) = 0;
    R_temp(1)   = 1e10;
    % the displacement increment and lamda at the previous increment
    dlamda      = lamda_sum;
    dU_last     = dU_sum;
    lamda_sum   = 0;
    dU_sum      = zeros(Struct_dof,1);
    tic
    %% Error checking phase
    while norm(R_temp) >= 0.0001 * norm(Pj * lamda_sum) % norm(Pj * lamda_sum) % lamda_1*Pj
        %% Predictor phase
        % Establishing geometric and elastic stiffness initial; and
        % for i > 1 and j > 1, stiffness matrix will inherit the last
        % iteration
        if (i == 1) && (j == 1)
            [ks,L1] = BuildGlobalMatrices(Struct_dof,Elem_num,Elem_Node_num,Node_update,E,A,Iz);
            [ks,Pj,R]  = ModifyGlobalMatrices(ks,Pj,R,freedof,fixdof);
        end  
        % incrementally secant predictor
        Predictor = ComType(1:2);
        if ismember(Predictor, {'P1','P2'}) && (i > 1) && (j == 1)
            Up = dU_last / dlamda;
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
        if j == 1
            toc;
            iter1_time(i) = toc;
        end
        j = j + 1;
        if j > 30
            error('no convergence')
        end
        %% Data output
        Fy(i)  = F(20) * 0.001;
        Uy(i)  = U(20);
        GSP_sum(i) = GSP;
    end
    % the number of increment/iteration
    Iter(i) = j - 1;
    % toc;
    % iter1_time(i) = toc;
    i = i + 1;
end
total_time = toc(total_time);
%% Computational efficiency
% Resize the array to remove extra preallocated elements
Fy = Fy(1 : i - 1); Uy = Uy(1 : i - 1); 
GSP_sum = GSP_sum(1 : i - 1);
Iter = Iter(1 : i - 1);
iter1_time = iter1_time(1 : i-1);
% exports
result{1}  = Fy; result{2} = Uy; 
result{3}  = GSP_sum;
result{4}  = [i,sum(Iter(:)),sum(Iter(:)) / i,total_time,sum(iter1_time(:))/i];
  