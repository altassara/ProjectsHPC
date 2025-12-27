% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich



% add necessary paths
addpaths_GP;
nlevels_a = 3;
nlevels_b = 4;

fprintf('       *********************************************\n')
fprintf('       ***  Recursive graph bisection benchmark  ***\n');
fprintf('       *********************************************\n')

% load cases
cases = {
    'airfoil1.mat';
    'netz4504_dual.mat';
    'stufe.mat';
    '3elt.mat';
    'barth4.mat';
    'ukerbe1.mat';
    'crack.mat';
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end


fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

%% Create results table
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');


for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});
    
    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % 1. Initialize the problem
    [params] = Initialize_case(sparse_matrices(c));
    W      = params.Adj;
    coords = params.coords;
    
    % 2. Recursive routines
    % i. Spectral
    [map_sp_8] = rec_bisection(@bisection_spectral, 3, W, coords, 0);
    [cut_sp_8] = cutsize(W, map_sp_8);
    
    [map_sp_16] = rec_bisection(@bisection_spectral, 4, W, coords, 0);
    [cut_sp_16] = cutsize(W, map_sp_16);

    % ii. Metis
    [map_me_8] = rec_bisection(@bisection_metis, 3, W, coords, 0);
    [cut_me_8] = cutsize(W, map_me_8);
    
    [map_me_16] = rec_bisection(@bisection_metis, 4, W, coords, 0);
    [cut_me_16] = cutsize(W, map_me_16);

    % iii. Coordinate    
    [map_co_8] = rec_bisection(@bisection_coordinate, 3, W, coords, 0);
    [cut_co_8] = cutsize(W, map_co_8);
    
    [map_co_16] = rec_bisection(@bisection_coordinate, 4, W, coords, 0);
    [cut_co_16] = cutsize(W, map_co_16);

    % iv. Inertial
    [map_in_8] = rec_bisection(@bisection_inertial, 3, W, coords, 0);
    [cut_in_8] = cutsize(W, map_in_8);
    
    [map_in_16] = rec_bisection(@bisection_inertial, 4, W, coords, 0);
    [cut_in_16] = cutsize(W, map_in_16);
    
    % 3. Calculate number of cut edges
    
    % 4. Visualize the partitioning result
    if strcmp(cases{c}, 'crack.mat')
        figure(1);
        gplotmap(W, coords, map_me_16);
        title('Spectral Recursive Partitioning p=16 (crack)');
        drawnow;
    end
    
    fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n', ...
        cut_sp_8, cut_sp_16, ...
        cut_me_8, cut_me_16, ...
        cut_co_8, cut_co_16, ...
        cut_in_8, cut_in_16);
    
end