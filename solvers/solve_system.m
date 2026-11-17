%% ========================================================================
% FILE: solve_system.m
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


function [u, info] = solve_system(A, b, method)

info = struct();

% Select and execute the requested solver.

switch lower(method)

    case 'backslash'

        u = solve_backslash(A, b);

    case 'gaussian'

        u = solve_gaussian(A, b);

    case 'lu'

        u = solve_lu(A, b);

    case 'jacobi'

        [u, info.iterations] = solve_jacobi(A, b);

    case 'gauss-seidel'

        [u, info.iterations] = solve_gauss_seidel(A, b);

    case 'sor'

        [u, info.iterations] = solve_sor(A,b);

    otherwise

        error('Unknown solution method: %s', method);

end

end