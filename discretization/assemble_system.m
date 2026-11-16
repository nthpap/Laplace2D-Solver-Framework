%% ========================================================================
% FILE: assemble_system.m
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


function [A, b] = assemble_system(problem, grid)

    %% Extract grid parameters

    hx = problem.grid.hx;
    hy = problem.grid.hy;

    nx = grid.nx;
    ny = grid.ny;
    n  = grid.n;

    %% Check boundary conditions

    sides = {'left', 'right', 'bottom', 'top'};

    for s = 1:length(sides)

        side = sides{s};

        if ~strcmpi(problem.boundary.(side).type, 'Dirichlet')
            error('Currently, only Dirichlet conditions are supported.');
        end

    end

    %% Initialize linear system

    A = sparse(n, n);
    b = zeros(n, 1);

    %% Finite difference coefficients

    cx = 1 / hx^2;
    cy = 1 / hy^2;

    c0 = 2*cx + 2*cy;

    %% Assemble matrix A and vector b

    for j = 1:ny
        for i = 1:nx

            % Global index of the interior node
            k = grid.K(j,i);

            % Central coefficient
            A(k,k) = c0;

            %% Left neighbor

            if i > 1

                A(k,grid.K(j,i-1)) = -cx;

            else

                y = grid.y(j+1);

                g = problem.boundary.left.func(y);

                b(k) = b(k) + cx*g;

            end

            %% Right neighbor

            if i < nx

                A(k,grid.K(j,i+1)) = -cx;

            else

                y = grid.y(j+1);

                g = problem.boundary.right.func(y);

                b(k) = b(k) + cx*g;

            end

            %% Bottom neighbor

            if j > 1

                A(k,grid.K(j-1,i)) = -cy;

            else

                x = grid.x(i+1);

                g = problem.boundary.bottom.func(x);

                b(k) = b(k) + cy*g;

            end

            %% Top neighbor

            if j < ny

                A(k,grid.K(j+1,i)) = -cy;

            else

                x = grid.x(i+1);

                g = problem.boundary.top.func(x);

                b(k) = b(k) + cy*g;

            end

        end
    end

end