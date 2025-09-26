%----------------------------------------------------------------------------------------
% This file is used to batch calculate the data in "SolutionProces.m", 
% and gives the displacement load curves and the corresponding computational efficiencies
%----------------------------------------------------------------------------------------
clear; clc;
CaseType = {'P1C1','P1C1','P3C1'};
number   = numel(CaseType);
% By default, five sets of data are stored in each case.
result_sym = cell(number,1);
for i = 1 : number                                                         % 1  2  3   4
    result_sym{i} = SolutionProcess_sym(CaseType{i});                              % Fy Uy GSP Time
end
result_asym = cell(number,1);
for i = 1 : number                                                         % 1  2  3   4
    result_asym{i} = SolutionProcess_asym(CaseType{i});                              % Fy Uy GSP Time
end
