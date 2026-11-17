%% ========================================================================
% FILE: solve_lu.m
% 
% DESCRIPTION:
%
% Solve the linear system using LU factorization.
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

function u = solve_lu(A, b)

% LU factorization with partial pivoting
[L, U, P] = lu(A);

% Forward substitution
y = L \ (P * b);

% Backward substitution
u = U \ y;

end