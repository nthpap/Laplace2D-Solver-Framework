%% ========================================================================
% FILE: convergence_study.m
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

function [h_values, E_values] = convergence_study( ...
    problem, M_values, N_values, exact_func, method)

%% Check input dimensions

if length(M_values) ~= length(N_values)
    error('M_values and N_values must have the same length.');
end

%% Initialize result vectors

h_values = zeros(size(M_values));
E_values = zeros(size(M_values));

%% Loop over all grid configurations

for q = 1:length(M_values)

    %% Update grid parameters

    problem_q = problem;

    problem_q.grid.M = M_values(q);
    problem_q.grid.N = N_values(q);

    Lx = problem.domain.xmax - problem.domain.xmin;
    Ly = problem.domain.ymax - problem.domain.ymin;

    problem_q.grid.hx = Lx / M_values(q);
    problem_q.grid.hy = Ly / N_values(q);

    %% Create computational grid

    grid_q = create_grid(problem_q);

    %% Number interior nodes

    grid_q = number_interior_nodes(problem_q, grid_q);

    %% Assemble linear system

    [A_q, b_q] = assemble_system(problem_q, grid_q);

    %% Solve linear system

    u_q = solve_system(A_q, b_q, method);

    %% Reconstruct numerical solution

    U_q = reconstruct_solution(problem_q, grid_q, u_q);

    %% Compute analytical solution

    U_exact_q = compute_exact_solution( ...
        problem_q, grid_q, exact_func);

    %% Compute numerical error

    [~, Emax_q] = compute_error(U_q, U_exact_q);

    %% Store results

    h_values(q) = max(problem_q.grid.hx, problem_q.grid.hy);
    E_values(q) = Emax_q;

end

end
