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
    % profile on
    result{i} = SolutionProcess(CaseType{i});                              % Fz Uz GSP Time
    % profile viewer
end
%--------------------------------------------------------------------
% Post process: displacement-load curve and computational efficiency
%--------------------------------------------------------------------
% Comparative data - Reference data
Horrigmoe_u = [10.16973	16.58693	21.31233	28.60461	38.28875	50.53977	65.41602	78.30876	92.42661	112.49495	134.13843	153.44838	169.1997	181.5674	193.46839	209.91977	238.33048	259.85728	276.19198	286.63452];
Horrigmoe_p = [8.34704	12.9534	16.32749	21.08055	26.6698	32.58178	38.3324	42.26394	45.87275	48.80674	50.11236	49.49622	47.61847	45.78473	43.73094	40.98766	37.99499	42.04389	48.9241	54.88009];
% Uz vs. Fz
Displ_load = DrawSphericalShell(result{2}{2},result{2}{1},result{3}{2},result{3}{1}, ...
    result{4}{2},result{4}{1},result{5}{2},result{5}{1},Horrigmoe_u,Horrigmoe_p);
% Uz vs. GSP
Displ_GSP  = GSPSphericalShell(result{2}{2},result{2}{3},result{3}{2},result{3}{3}, ...
    result{4}{2},result{4}{3},result{5}{2},result{5}{3});
% Computational time
Runtime    = [result{2}{4};result{3}{4};result{4}{4};result{5}{4}]';