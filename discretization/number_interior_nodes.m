%% ========================================================================
% FILE: number_interior_nodes.m
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

function grid = number_interior_nodes(problem, grid)

%% Number of interior nodes

nx = problem.grid.M - 1;
ny = problem.grid.N - 1;

%% Total number of unknowns

grid.nx = nx;
grid.ny = ny;

grid.n = nx * ny;

%% Interior node numbering

grid.K = zeros(ny, nx);

for j = 1:ny
    for i = 1:nx

        k = (j-1)*nx + i;

        grid.K(j,i) = k;

    end
end

end