%% ========================================================================
% FILE: solve_jacobi.m
% 
% DESCRIPTION:
%
% Solve the linear system using the Jacobi iterative method.
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

function [u, k] = solve_jacobi(A, b)

% Parameters
tol = 1e-8;
max_iter = 50000;

% System dimensions
n = length(b);

if size(A,1) ~= n || size(A,2) ~= n
    error('Incompatible dimensions of A and b.');
end

% Initial approximation
u = zeros(n,1);

% Extract diagonal and off-diagonal parts
D = diag(A);
R = A - spdiags(D,0,n,n);

% Check diagonal elements
if any(D == 0)
    error('Matrix contains zero diagonal elements.');
end

% Initialize iteration counter
k = 0;

% Jacobi iteration
for k = 1:max_iter

    u_new = (b - R*u) ./ D;

    % Convergence criterion
    if norm(u_new-u,inf) < tol
        u = u_new;
        return;
    end

    % Update approximation
    u = u_new;

end

warning('Jacobi method did not converge within max_iter.');

end
