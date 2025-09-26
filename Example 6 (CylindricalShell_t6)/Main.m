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
Sez_t6_u = [2.11599	4.51411	6.63009	8.74608	11.28527	14.24765	15.94044	16.78683	16.9279	15.79937	14.38871	16.36364	19.32602	21.58307	23.69906	25.81505	27.93103	29.48276];
Sez_t6_P = [0.1791	0.32276	0.41418	0.49254	0.5709	0.58396	0.45336	0.20522	-0.04291	-0.17351	-0.33022	-0.38246	-0.33022	-0.22575	-0.09515	0.10075	0.375	0.62313];
% Uz vs. Fz
Displ_load = DrawCylindricalShell_t6(result{2}{2},result{2}{1},result{3}{2},result{3}{1}, ...
    result{4}{2},result{4}{1},result{5}{2},result{5}{1},Sez_t6_u,Sez_t6_P);
% Uz vs. GSP
Displ_GSP  = GSPCylindricalShell_t6(result{2}{2},result{2}{3},result{3}{2},result{3}{3}, ...
    result{4}{2},result{4}{3},result{5}{2},result{5}{3});
% Computational time
Runtime    = [result{2}{4};result{4}{4};result{3}{4};result{5}{4}]';