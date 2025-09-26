function result = SolutionProcess_asym(ComType)
%--------------------------------------------------------------------------
% Deep arh's frame problem
%--------------------------------------------------------------------------
% clc;
% Timer
total_time = tic;
%% Problem definition
% geometric data
A             = 1;
Iz            = 1;
% material data
E             = 2000;
% Coordinate calculation
Node_coor     = [-49.990556	247.5019077
        -46.038216	248.267462
        -42.074172	248.9699059
        -38.099434	249.6090606
        -34.11501	250.1847639
        -30.121914	250.6968693
        -26.121161	251.1452467
        -22.113768	251.5297821
        -18.100754	251.8503776
        -14.083138	252.106952
        -10.061942	252.2994398
        -6.038189	252.4277922
        -2.0129	252.4919766
        0	252.5
        2.0129	252.4919766
        6.038189	252.4277922
        10.061942	252.2994398
        14.083138	252.106952
        18.100754	251.8503776
        22.113768	251.5297821
        26.121161	251.1452467
        30.121914	250.6968693
        34.11501	250.1847639
        38.099434	249.6090606
        42.074172	248.9699059
        46.038216	248.267462
        49.990556	247.5019077];
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
for node = 1:1:Elem_num
    ElemForce{node} = zeros(6,1);
end
% pre-allocating memory
Fy      = zeros(10000,1);
Uy      = zeros(10000,1);
GSP_sum = zeros(10000,1);
Iter    = zeros(10000,1);
iter1_time = zeros(10000,1);
%% Boundary conditions and nodal forces
% fixed dofs
% BCtype = 1
inf_bc           = [[1   1 1 0]
                    [27   1 1 0]];
inf_nf           = [[15   0 -1 0]];
[freedof,fixdof] = FindFixedDof(inf_bc,Struct_dof,Node_dof);
% Nodal forces
[Pj,F,P]         = BuildForceVector(inf_nf,Struct_dof);
% Nodal coordinal
Node_update = Node_coor;
%--------------------------------------------------------------------------
% Iterative solver
%--------------------------------------------------------------------------
while -U(41) < 11
    j           = 1;
    R(:,:)      = 0;
    R_temp(:,:) = 0;
    R_temp(1)   = 1e10;
    % the displacement increment and lamda at the previous increment
    dlamda      = lamda_sum;
    dU_last     = dU_sum;
    lamda_sum   = 0;
    dU_sum      = zeros(Struct_dof,1);
    % tic
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
        % if j == 1
        %     toc;
        %     iter1_time(i) = toc;
        % end
        j = j + 1;
        %% Data output
        Fy(i)  = -F(44);
        Uy(i)  = -U(41);
        GSP_sum(i) = GSP;
        if j > 30
            error('no convergence')
        end
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
  