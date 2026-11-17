%% ========================================================================
% FILE: main.m
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

clear; clc; close all;

%% Add project folders to MATLAB path

project_path = fileparts(mfilename('fullpath'));
addpath(genpath(project_path));

%% Create problem

problem = create_problem(1, 1, 20, 20);

%% Define boundary conditions

problem = set_boundary_conditions(problem, ...
    'left', 'Dirichlet', @(y) 0);

problem = set_boundary_conditions(problem, ...
    'right', 'Dirichlet', @(y) 0);

problem = set_boundary_conditions(problem, ...
    'bottom', 'Dirichlet', @(x) 0);

problem = set_boundary_conditions(problem, ...
    'top', 'Dirichlet', @(x) sin(pi*x));

%% Analytical solution

exact_func = @(x,y) ...
    (sinh(pi*y)./sinh(pi)) .* sin(pi*x);

%% Create computational grid

grid = create_grid(problem);

%% Number interior nodes

grid = number_interior_nodes(problem, grid);


%% Display grid size

disp(size(grid.X));
disp(size(grid.Y));

%% Assemble linear system

[A, b] = assemble_system(problem, grid);

%% Display system information

fprintf('\nLINEAR SYSTEM\n');
fprintf('--------------------------\n');

fprintf('Size of A: %d x %d\n', size(A,1), size(A,2));
fprintf('Size of b: %d x %d\n', size(b,1), size(b,2));

fprintf('Nonzero elements of A: %d\n', nnz(A));

fprintf('Central coefficient: %.2f\n', full(A(1,1)));

%% Solve linear system

%method = 'backslash';

%method = 'gaussian';

%method = 'lu';

%method = 'jacobi';

%method = 'gauss-seidel';

method = 'sor';

u = solve_system(A, b, method);

%% Display solution information

fprintf('\nSOLUTION\n');
fprintf('--------------------------\n');

fprintf('Number of unknowns: %d\n', length(u));
fprintf('Minimum value: %.6f\n', min(u));
fprintf('Maximum value: %.6f\n', max(u));

%% Reconstruct solution

U = reconstruct_solution(problem, grid, u);

%% Compute analytical solution

U_exact = compute_exact_solution(problem, grid, exact_func);

fprintf('\nANALYTICAL SOLUTION\n');
fprintf('--------------------------\n');

fprintf('Size of U_exact: %d x %d\n', ...
    size(U_exact,1), size(U_exact,2));

%% Display solution matrix information

fprintf('\nSOLUTION MATRIX\n');
fprintf('--------------------------\n');

fprintf('Size of U: %d x %d\n', size(U,1), size(U,2));

fprintf('Minimum value: %.6f\n', min(U(:)));
fprintf('Maximum value: %.6f\n', max(U(:)));

%% Compute numerical error

[E, Emax] = compute_error(U, U_exact);

%% Display error information

fprintf('\nERROR ANALYSIS\n');
fprintf('--------------------------\n');

fprintf('Maximum absolute error: %.6e\n', Emax);

%% Convergence study

M_values = [10 20 50 80 100];
N_values = [10 20 50 80 100];

[h_values, E_values] = convergence_study( ...
    problem, M_values, N_values, exact_func, method);

%% Display convergence results

fprintf('\nCONVERGENCE STUDY\n');
fprintf('------------------------------------------\n');
fprintf('   M          h             Emax\n');
fprintf('------------------------------------------\n');

for q = 1:length(M_values)

    fprintf('%4d     %.6f     %.6e\n', ...
        M_values(q), h_values(q), E_values(q));

end

%% Graphical presentation of results

plot_results( ...
    grid.X, grid.Y, ...
    U_exact, U, ...
    problem.grid.M, problem.grid.N, ...
    M_values, N_values, ...
    h_values, E_values);