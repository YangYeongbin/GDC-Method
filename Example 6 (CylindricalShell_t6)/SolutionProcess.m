function result = SolutionProcess(ComType)
%--------------------------------------------------------------------------
% Cylindrical shell problem with t = 12.7
%--------------------------------------------------------------------------
clc;
% Timer
total_time = tic;
%% Problem definition
% geometric data
t             = 6.35;
MU            = 0.3;
% material data
E             = 3.10275;
% Coordinate calculation
Node_coor     = [0          254      2540;
                 63.39422   254      2539.208769;
                 126.78844  254      2536.833596;
                 190.18266  254      2532.870023;
                 253.57688  254      2527.31058;
                 0          190.5      2540;
                 63.39422   190.5      2539.208769;
                 126.78844  190.5      2536.833596;
                 190.18266  190.5      2532.870023;
                 253.57688  190.5      2527.31058;
                 0          127      2540;
                 63.39422   127      2539.208769;
                 126.78844  127      2536.833596;
                 190.18266  127      2532.870023;
                 253.57688  127      2527.31058;
                 0          63.5      2540;
                 63.39422   63.5     2539.208769;
                 126.78844  63.5      2536.833596;
                 190.18266  63.5      2532.870023;
                 253.57688  63.5      2527.31058;
                 0          0      2540;
                 63.39422   0      2539.208769;
                 126.78844  0      2536.833596;
                 190.18266  0      2532.870023;
                 253.57688  0      2527.31058;];
% LoadParameter
lamda_initial = 0.01;
%% Mesh
Elem_num   = 32;
Node_num   = 25;
Node_dof   = 6;
Struct_dof = Node_dof * Node_num;
%% Initialization
i = 1;
Elem_Node_num = [1 6 7;
                 1 7 2;
                 2 7 8;
                 2 8 3;
                 3 8 9;
                 3 9 4;
                 4 9 10;
                 4 10 5;
                 6 11 12;
                 6 12 7;
                 7 12 13;
                 7 13 8;
                 8 13 14;
                 8 14 9;
                 9 14 15;
                 9 15 10;
                 11 16 17;
                 11 17 12;
                 12 17 18;
                 12 18 13;
                 13 18 19;
                 13 19 14;
                 14 19 20;
                 14 20 15;
                 16 21 22;
                 16 22 17;
                 17 22 23;
                 17 23 18;
                 18 23 24;
                 18 24 19;
                 19 24 25;
                 19 25 20];
U         = zeros(Struct_dof,1);
R         = zeros(Struct_dof,1);
R_temp    = zeros(Struct_dof,1);
dU        = zeros(Struct_dof,1);
ElemForce = cell(Elem_num,1);
result    = {};
lamda_sum = 0;
dU_sum    = zeros(Struct_dof,1);
for elem = 1 : Elem_num
    ElemForce{elem} = zeros(18,1);
end
% pre-allocating memory
Fz      = zeros(5000,1);
Uz      = zeros(5000,1);
GSP_sum = zeros(5000,1);
Iter    = zeros(5000,1);
iter1_time = zeros(5000,1);
%% Boundary conditions and nodal forces
% fixed dofs
% BCtype = 1
inf_bc           = [[1   1 0 0 0 1 1]
                    [5   1 1 1 0 0 0]
                    [6   1 0 0 0 1 1]
                    [10  1 1 1 0 0 0]
                    [11  1 0 0 0 1 1]
                    [15  1 1 1 0 0 0]
                    [16  1 0 0 0 1 1]
                    [20  1 1 1 0 0 0]
                    [21  1 1 0 1 1 1]
                    [22  0 1 0 1 0 1]
                    [23  0 1 0 1 0 1]
                    [24  0 1 0 1 0 1]
                    [25  1 1 1 1 0 1]];
inf_nf           = [[21   0 0 -1 0 0 0]];
[freedof,fixdof] = FindFixedDof(inf_bc,Struct_dof,Node_dof);
% Nodal forces
[Pj,F,P]         = BuildForceVector(inf_nf,Struct_dof); 
% Nodal coordinal
Node_update = Node_coor;
%--------------------------------------------------------------------------
% Iterative solver
%--------------------------------------------------------------------------
while U(123) > -30
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
    while norm(R_temp) >= (0.0001 * norm(Pj*lamda_sum))  % P-Fint1
        %% Predictor phase
        % Establishing geometric and elastic stiffness initial; and
        % for i > 1 and j > 1, stiffness matrix will inherit the last iteration
        if (i == 1) && (j == 1)
            [ks]       = BuildGlobalMatrices(Struct_dof,Elem_num,Elem_Node_num,Node_update,E,t,MU);
            [ks,Pj,R]  = ModifyGlobalMatrices(ks,Pj,R,freedof,fixdof);
        end
        % embedded secant predictor
        Predictor = ComType(1:2);
        if ismember(Predictor, {'P1','P2'}) && (i > 1) && (j == 1)
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
        [ElemForce,ks,F] = InternalForceBlance(Struct_dof,Elem_num,Elem_Node_num,Node_update,ElemForce,dU,ComType,E,MU,t);
        % Update resulting nodal forces and displacement
        U             = U + dU;
        P             = P + lamda * Pj;
        lamda_sum     = lamda_sum + lamda;
        dU_sum        = dU_sum + dU;
        % unblance force
        R             = P - F;
        [ks,F,R]     = ModifyGlobalMatrices(ks,F,R,freedof,fixdof);
        R_temp        = R;
        if j == 1
            toc;
            iter1_time(i) = toc;
        end
        j = j + 1;
        %% Data output
        Fz(i)  = -F(123) * 4;
        Uz(i)  = -U(123);
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
Fz = Fz(1 : i - 1); Uz = Uz(1 : i - 1); 
GSP_sum = GSP_sum(1 : i - 1);
Iter = Iter(1 : i - 1);
% exports
result{1}  = Fz; result{2} = Uz; 
result{3} = GSP_sum;
result{4}  = [i,sum(Iter(:)),sum(Iter(:)) / i,total_time,sum(iter1_time(:))/i];
  