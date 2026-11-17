%% ========================================================================
% FILE: solve_sor.m
% 
% DESCRIPTION:
%
% Solve the linear system using the Successive Over-Relaxation method.
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

function [u, k] = solve_sor(A, b)

tol = 1e-8;
max_iter = 50000;
%omega = 1.5;
omega = 1.7295;

n = length(b);

if size(A,1) ~= n || size(A,2) ~= n
    error('Incompatible dimensions of A and b.');
end

D = spdiags(diag(A), 0, n, n);
L = tril(A, -1);
U = triu(A, 1);

if any(diag(A) == 0)
    error('Matrix contains zero diagonal elements.');
end

DL = D + omega * L;

u = zeros(n,1);

for k = 1:max_iter

    u_old = u;

    u = DL \ (omega*b - (omega*U + (omega-1)*D)*u_old);

    if norm(u-u_old,inf) < tol
        return;
    end

end

warning('SOR method did not converge within max_iter.');

end
