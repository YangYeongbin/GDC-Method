%----------------------------------------------------------------------------------------
% This file is used to batch calculate the data in "SolutionProces.m", 
% and gives the displacement load curves and the corresponding computational efficiencies
%----------------------------------------------------------------------------------------
clear; clc;
CaseType = {'P1C1','P1C1','P3C1'};
number   = numel(CaseType);
% By default, five sets of data are stored in each Case.
result   = cell(number,1);
for i = 1 : number                                                          % 1  2  3  4   5
    result{i} = SolutionProcess(CaseType{i});                               % Fy Ux Uy GSP Time
end
%--------------------------------------------------------------------
% Post process: displacement-load curve and computational efficiency
%--------------------------------------------------------------------
% Comparative data - Papadrakakis' solution
ExactSolution = load('ExactSolution.txt');
Papadrakakis_u = ExactSolution(:,1);
Papadrakakis_P = ExactSolution(:,2);
arc_ok   = load('arc_ok.txt');
arc_x = arc_ok(:,2);
arc_y = arc_ok(:,1);
arc_fail = load('arc.txt');
arc_x1 = arc_fail(:,2);
arc_y1 = arc_fail(:,1);

Displ_load = DrawTwoMemberTruss(result{2}{3},result{2}{1},result{3}{3},result{3}{1}, ...
   Papadrakakis_u,Papadrakakis_P,arc_x,arc_y,arc_x1,arc_y1);
Displ_GSP  = GSPTwoMemberTruss(result{2}{3},result{2}{4},result{3}{3},result{3}{4});
Runtime    = [result{2}{5};result{3}{5}]';