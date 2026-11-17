%% ========================================================================
% FILE: solve_gauss_seidel.m
% 
% DESCRIPTION:
%
% Solve the linear system using the Gauss-Seidel iterative method.
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

function [u, k] = solve_gauss_seidel(A, b)

% Parameters
tol = 1e-8;
max_iter = 50000;

% System dimensions
n = length(b);

D = spdiags(diag(A), 0, n, n);
L = tril(A, -1);
U = triu(A, 1);

if any(diag(A) == 0)
    error('Matrix contains zero diagonal elements.');
end

DL = D + L;

u = zeros(n,1);

for k = 1:max_iter

    u_old = u;

    u = DL \ (b - U*u_old);

    if norm(u-u_old,inf) < tol
        return;
    end

end

warning('Gauss-Seidel method did not converge within max_iter.');

end