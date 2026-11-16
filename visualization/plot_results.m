%% ========================================================================
% FILE: plot_results.m
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

function plot_results(X, Y, U_exact, U, ...
    M, N, M_values, N_values, ...
    h_values, E_values)

%% Graphical presentation of results

figure('Name','Numerical solution and convergence',...
    'Color','w');

tiledlayout(2,2,'TileSpacing','compact','Padding','compact');

% Analytical solution - top left
nexttile;

surf(X,Y,U_exact);

xlabel('x');
ylabel('y');
zlabel('u(x,y)');

title(sprintf('Analytical solution (M = %d, N = %d)',M,N));

colorbar;
shading interp;
view(3);

% Numerical solution - top right
nexttile;

surf(X,Y,U);

xlabel('x');
ylabel('y');
zlabel('u(x,y)');

title(sprintf('Numerical solution (M = %d, N = %d)',M,N));

colorbar;
shading interp;
view(3);

% Convergence study - bottom
nexttile([1 2]);

hold on;

% Different color for each grid
colors = lines(length(M_values));

for q = 1:length(M_values)

    loglog(h_values(q),E_values(q),'o',...
        'Color',colors(q,:),...
        'MarkerFaceColor',colors(q,:),...
        'MarkerSize',8);

end

% Connect consecutive points
for q = 1:length(M_values)-1

    loglog(h_values(q:q+1),E_values(q:q+1),'-',...
        'Color',colors(q,:),...
        'LineWidth',1.5);

end

xlabel('Mesh size h');
ylabel('Maximum absolute error E_{max}');

title('Convergence as the mesh is refined');

% Dynamic legend
legend_labels = cell(1,length(M_values));

for q = 1:length(M_values)

    legend_labels{q} = sprintf('M = %d, N = %d',...
        M_values(q),N_values(q));

end

legend(legend_labels,'Location','best');

grid on;

end
