%----------------------------------------------------------------------------------------
% This file is used to batch calculate the data in "SolutionProces.m", 
% and gives the displacement load curves and the corresponding computational efficiencies
%----------------------------------------------------------------------------------------
clear; clc;
CaseType = {'P1C1','P1C1','P3C1','P3C2'};
number   = numel(CaseType);
% By default, five sets of data are stored in each case.
result   = cell(number,1);
for i = 1 : number                                                         % 1  2  3   4
    result{i} = SolutionProcess(CaseType{i});                              % Fy Uy GSP Time
end
%--------------------------------------------------------------------
% Post process: displacement-load curve and computational efficiency
%--------------------------------------------------------------------
% arc-length method
arc = load('arc_asym.txt');
arc_u = arc(:,1); arc_p = arc(:,2);
% Uy vs. Fy
Displ_load = DrawDeepArch_asym(result{2}{2},result{2}{1},result{3}{2},result{3}{1},result{4}{2},result{4}{1},arc_u,arc_p);
% Uy vs. GSP
Displ_GSP  = GSPDeepArch_asym(result{2}{2},result{2}{3},result{3}{2},result{3}{3},result{4}{2},result{4}{3});
% Computational time
Runtime    = [result{2}{4};result{3}{4}]';