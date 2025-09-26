%----------------------------------------------------------------------------------------
% This file is used to batch calculate the data in "SolutionProces.m", 
% and gives the displacement load curves and the corresponding computational efficiencies
%----------------------------------------------------------------------------------------
clear; clc;
CaseType = {'P1C2','P1C2','P2C2','P3C2','P4C2'};
number   = numel(CaseType);
% By default, five sets of data are stored in each case.
result   = cell(number,1);
for i = 1 : number                                                         % 1  2  3   4
    result{i} = SolutionProcess(CaseType{i});                              % Fz Uz GSP Time
end
%--------------------------------------------------------------------
% Post process: displacement-load curve and computational efficiency
%--------------------------------------------------------------------
% Comparative data - Reference data
Sez_t12_u = [0.693	1.638	3.087	4.477	5.802	7.057	8.237	9.339	10.358	11.293	12.141	12.903	13.583	14.188	14.728	15.217	15.676	16.125	16.59	17.094	17.657	18.299	19.028	19.852	20.771	21.78	22.875	24.049	24.663	25.293	25.94	26.601	27.276	27.964	28.663	29.374];
Sez_t12_P = [0.2631	0.594	1.0419	1.4058	1.6941	1.9143	2.0724	2.1738	2.2236	2.2263	2.1858	2.1069	1.9947	1.8546	1.6929	1.5165	1.3326	1.149	0.9735	0.8151	0.6816	0.582	0.525	0.5187	0.5715	0.6909	0.885	1.1613	1.3329	1.5279	1.7478	1.9932	2.2653	2.5647	2.8929	3.2505];
% Uz vs. Fz
Displ_load = DrawCylindricalShell_t12(result{2}{2},result{2}{1},result{3}{2},result{3}{1}, ...
    result{4}{2},result{4}{1},result{5}{2},result{5}{1},Sez_t12_u,Sez_t12_P);
% Uz vs. GSP
Displ_GSP  = GSPCylindricalShell_t12(result{2}{2},result{2}{3},result{3}{2},result{3}{3}, ...
    result{4}{2},result{4}{3},result{5}{2},result{5}{3});
% Computational time
Runtime    = [result{2}{4};result{4}{4};result{3}{4};result{5}{4}]';