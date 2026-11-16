%% ========================================================================
% FILE: create_problem.m
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

function problem = create_problem(Lx, Ly, M, N)

%% Domain

problem.domain.xmin = 0;
problem.domain.xmax = Lx;

problem.domain.ymin = 0;
problem.domain.ymax = Ly;

%% Grid

problem.grid.M = M;
problem.grid.N = N;

problem.grid.hx = Lx / M;
problem.grid.hy = Ly / N;

%% Boundary conditions

problem.boundary.left.type = '';
problem.boundary.left.func = [];

problem.boundary.right.type = '';
problem.boundary.right.func = [];

problem.boundary.bottom.type = '';
problem.boundary.bottom.func = [];

problem.boundary.top.type = '';
problem.boundary.top.func = [];

end