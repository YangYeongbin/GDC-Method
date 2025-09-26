%----------------------------------------------------------------------------------------
% This file is used to batch calculate the data in "SolutionProces.m", 
% and gives the displacement load curves and the corresponding computational efficiencies
%----------------------------------------------------------------------------------------
clear; clc;
CaseType = {'P1C2','P1C2','P3C2','P2C2','P4C2'};
number   = numel(CaseType);
% By default, five sets of data are stored in each case.
result   = cell(number,1);
for i = 1 : number                                                         % 1  2  3   4
    result{i} = SolutionProcess(CaseType{i});                              % Fy Uy GSP Time
end
%--------------------------------------------------------------------
% Post process: displacement-load curve and computational efficiency
%--------------------------------------------------------------------
% Comparative data - Reference data
Ref_U = [0.00261 0.04698 0.09559 0.13944 0.19192	0.2444	0.29564	0.35499	0.40624	0.45062	0.50732	0.56121	0.59414	0.61175	0.61105	0.59766	0.58005	0.54906	0.52881	0.51331	0.51807	0.5436	0.58956	0.64345	0.68713	0.73168	0.77412	0.80582	0.83276];
Ref_P = [0.00E+00	0.49313	0.84453	1.08911	1.27579	1.42554	1.54333	1.6771	1.76096	1.80688	1.81886	1.71903	1.54333	1.32571	1.02422	0.77565	0.53107	0.19065	-0.06092	-0.3634	-0.64592	-0.85256	-0.93243	-0.87153	-0.77569	-0.6569	-0.50017	-0.34743	-0.18371];
% Uy vs. Fy
Displ_load = DrawLeeFrame(result{2}{2},result{2}{1},result{3}{2},result{3}{1}, ...
    result{4}{2},result{4}{1},result{5}{2},result{5}{1},Ref_U,Ref_P);
% Uy vs. GSP
Displ_GSP  = GSPLeeFrame(result{2}{2},result{2}{3},result{3}{2},result{3}{3}, ...
    result{4}{2},result{4}{3},result{5}{2},result{5}{3});
% Computational time
Runtime    = [result{2}{4};result{3}{4};result{4}{4};result{5}{4}]';