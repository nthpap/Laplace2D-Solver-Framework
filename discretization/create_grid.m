%% ========================================================================
% FILE: create_grid.m
% 
% DESCRIPTION:
%
% TEST FOR NOW...
% 
% AUTHOR:     Nikolaos Theodoros Papadopoulos
% SUPERVISOR: Prof. Theodoros Zygiridis
%
% UNIVERSITY: University of Western Macedonia, 
% SCHOOL:     School of Engineering
% DEPARTMENT: Electrical and Computer Engineering
%
% DATE: November 2026
%
% COPYRIGHTS:
% Copyright (c) 2026, Nikolaos Theodoros Papadopoulos, Theodoros Zygiridis. All rights reserved.
% Unauthorized redistribution, reproduction, or use of this code 
% without the express written consent of the creator is strictly prohibited.
%
% CONTACT: nthpapadopoulos@gmail.com
%% ========================================================================

function grid = create_grid(problem)

%% Extract domain and grid parameters

xmin = problem.domain.xmin;
xmax = problem.domain.xmax;

ymin = problem.domain.ymin;
ymax = problem.domain.ymax;

M = problem.grid.M;
N = problem.grid.N;

%% Generate grid coordinates

grid.x = linspace(xmin, xmax, M+1);
grid.y = linspace(ymin, ymax, N+1);

%% Generate 2D computational grid

[grid.X, grid.Y] = meshgrid(grid.x, grid.y);

end