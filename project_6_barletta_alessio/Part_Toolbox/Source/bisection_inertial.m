%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial : Inertial partition of a graph.
%
% [p1,p2] = bisection_inertial(A,xy) returns a list of the vertices on one side of a partition
%     obtained by bisection with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.


%disp(' ');
%disp(' HPC Lab at USI:   ');
%disp(' Implement inertial bisection');
%disp(' ');


% Steps
% 1. Calculate the center of mass.
center_mass = mean(xy);

% 2. Construct the matrix M.
diff_x = xy(:, 1) - center_mass(:, 1);
diff_y = xy(:, 2) - center_mass(:, 2);

S_xx = norm(diff_x)^2;
S_yy = norm(diff_y)^2;
S_xy = sum(diff_x .* diff_y);

M = [ S_xx, S_xy; S_xy, S_yy];

%  (Consult the pdf of the assignment for the creation of M) 
% 3. Calculate the smallest eigenvector of M.  
[eigenVectors, eigenValues] = eig(M);

d = diag(eigenValues);

[d_sorted, idx] = sort(d, 'ascend'); 

u = eigenVectors(:, idx(1));

% 5. Partition the points around the line L.
R = [0 -1; 1 0];
u_rot = R * u;
[part1,part2] = partition(xy,u_rot);

%   (you may use the function partition.m)


% <<<< Dummy implementation to generate a partitioning

if picture == 1
    gplotpart(A,xy,part1);
    title('Inertial bisection using the Fiedler Eigenvector');
end

% Dummy implementation to generate a partitioning >>>>

end
