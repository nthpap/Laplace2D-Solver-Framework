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
pivot_tol = eps(matrix_scale);

% Forward elimination with partial pivoting
for k = 1:n-1

    % Find nonzero elements in the current column
    [rows, ~, values] = find(A(k:n,k));

    % Check for a zero or numerically negligible pivot
    if isempty(values)
        error('Matrix is singular or numerically singular.');
    end

    % Find the largest absolute element
    [pivot_value, pivot_index] = max(abs(values));

    if pivot_value <= pivot_tol
        error('Matrix is singular or numerically singular.');
    end

    % Determine the pivot row
    pivot_row = k + rows(pivot_index) - 1;

    % Swap rows if necessary
    if pivot_row ~= k

        A([k pivot_row], :) = A([pivot_row k], :);
        b([k pivot_row]) = b([pivot_row k]);

    end

    % Identify nonzero elements of the pivot row
    [~, pivot_cols, pivot_values] = find(A(k,k+1:n));

    pivot_cols = pivot_cols + k;

    % Identify rows containing nonzero elements below the pivot
    [relative_rows, ~, column_values] = find(A(k+1:n,k));

    affected_rows = relative_rows + k;

    % Eliminate only the affected rows
    for j = 1:length(affected_rows)

        i = affected_rows(j);

        % Elimination multiplier
        m = column_values(j) / A(k,k);

        % Update only nonzero positions of the pivot row
        if ~isempty(pivot_cols)

            A(i,pivot_cols) = A(i,pivot_cols) ...
                - m * pivot_values;

        end

        % Eliminate the element below the pivot
        A(i,k) = 0;

        % Update the right-hand side
        b(i) = b(i) - m*b(k);

    end

end

% Check the final diagonal element
if abs(A(n,n)) <= pivot_tol
    error('Matrix is singular or numerically singular.');
end

% Back substitution
u = zeros(n,1);

for i = n:-1:1

    u(i) = (b(i) - A(i,i+1:n)*u(i+1:n)) / A(i,i);

end

end
