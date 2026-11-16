%% ========================================================================
% FILE: reconstruct_solution.m
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

function U = reconstruct_solution(problem, grid, u)

%% Initialize solution matrix

U = zeros(problem.grid.N + 1, problem.grid.M + 1);

%% Insert interior solution values

for j = 1:grid.ny
    for i = 1:grid.nx

        k = grid.K(j,i);

        U(j+1,i+1) = u(k);

    end
end

%% Apply boundary conditions

% Bottom boundary
for i = 1:problem.grid.M+1

    x = grid.x(i);

    U(1,i) = problem.boundary.bottom.func(x);

end

% Top boundary
for i = 1:problem.grid.M+1

    x = grid.x(i);

    U(end,i) = problem.boundary.top.func(x);

end

% Left boundary
for j = 1:problem.grid.N+1

    y = grid.y(j);

    U(j,1) = problem.boundary.left.func(y);

end

% Right boundary
for j = 1:problem.grid.N+1

    y = grid.y(j);

    U(j,end) = problem.boundary.right.func(y);

end

end
