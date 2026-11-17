%% ========================================================================
% FILE: solve_gaussian.m
% 
% DESCRIPTION:
%
% Solve the linear system using Gaussian Elimination with Partial Pivoting
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


function u = solve_gaussian(A, b)

n = length(b);

% Preserve the original matrix scale
matrix_scale = norm(A, inf);

% Forward elimination
for k = 1:n-1

    % Find the largest absolute element in the current column
    [pivot_value, pivot_index] = max(abs(A(k:n,k)));

    % Determine the pivot row
    pivot_row = k + pivot_index - 1;

    % Check for a zero or numerically negligible pivot
    if pivot_value <= eps(matrix_scale)
        error('Matrix is singular or numerically singular.');
    end

    % Swap rows if necessary
    if pivot_row ~= k

        A([k pivot_row],:) = A([pivot_row k],:);

        b([k pivot_row]) = b([pivot_row k]);

    end

    % Eliminate elements below the pivot
    for i = k+1:n

        m = A(i,k) / A(k,k);

        A(i,k) = 0;

        A(i,k+1:n) = A(i,k+1:n) ...
            - m * A(k,k+1:n);

        b(i) = b(i) - m*b(k);

    end

end

% Check the final diagonal element
if abs(A(n,n)) <= eps(matrix_scale)
    error('Matrix is singular or numerically singular.');
end

% Back substitution
u = zeros(n,1);

for i = n:-1:1

    u(i) = (b(i) - A(i,i+1:n)*u(i+1:n)) / A(i,i);

end

end