%% ========================================================================
% FILE: set_boundary_conditions.m
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

function problem = set_boundary_conditions(problem, side, type, func)

%% Check boundary side

if ~isfield(problem.boundary, side)
    error('Invalid boundary side.');
end

%% Check boundary type

if ~strcmpi(type, 'Dirichlet') && ...
        ~strcmpi(type, 'Neumann')

    error('Boundary type must be Dirichlet or Neumann.');

end

%% Check boundary function

if ~isa(func, 'function_handle')
    error('Boundary condition must be a function.');
end

%% Store boundary condition

problem.boundary.(side).type = type;
problem.boundary.(side).func = func;

end