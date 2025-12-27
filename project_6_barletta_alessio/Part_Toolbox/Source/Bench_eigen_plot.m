% Visualize information from the eigenspectrum of the graph Laplacian
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

% add necessary paths
addpaths_GP;

% Graphical output at bisection level
picture = 0;
% Cases under consideration
graphs = {'airfoil1', '3elt', 'barth4', 'mesh3e1', 'crack'};

for k = 1:length(graphs)
    % Initialize the cases
    clear Problem A xy mat coordinates W coords;
    load(graphs{k});
    
    W = Problem.A;
    coords = Problem.aux.coord;


% Steps
% 1. Construct the graph Laplacian of the graph in question.
    L = diag(sum(W, 2)) - W;

% 2. Compute eigenvectors associated with the smallest eigenvalues.
    opts.tol = 1e-6;
    [V, D_eig] = eigs(L, 3, 'sm', opts);
    [~, idx] = sort(diag(D_eig));
    V = V(:, idx);
    
    v1 = V(:, 1);
    v2 = V(:, 2);
    v3 = V(:, 3);

% 3. Perform spectral bisection.

    fiedlerVector = V(:, 2);


    medianValue = median(fiedlerVector);

    n = size(W, 1);
    map = zeros(n, 1);
    map(fiedlerVector < medianValue) = 0; 
    map(fiedlerVector >= medianValue) = 1;
    [part1, part2] = other(map);

% 4. Visualize:
%   i.   The first and second eigenvectors.
    if strcmp(graphs{k}, 'airfoil1')
        figure;
        subplot(2, 1, 1);
        plot(v1);
        title(['Eigenvector 1: ' graphs{k}]);
        axis tight;
        
        subplot(2, 1, 2);
        plot(v2);
        title(['Eigenvector 2: ' graphs{k}]);
        axis tight;
    end

%   ii.  The second eigenvector projected on the coordinate system space of graphs.
    if ~isempty(coords)
        figure('Name', ['3D PROJECTION: ' graphs{k}], 'NumberTitle', 'off');
        
        h_line = gplotg(W, coords);
        set(h_line, 'Color', [0.8 0.8 0.8]); 
        hold on;
        
        scatter3(coords(:,1), coords(:,2), v2, 30, v2, 'filled');
        
        title(['3d projection of v_2 ' graphs{k}]);
        colorbar;
        
        axis normal; 
        grid on;
        view(-45, 30);

    end

%   iii. The spectral bi-partitioning results using the spectral coordinates of each graph.
    map_partition = zeros(n, 1);
    map_partition(part2) = 1;
    
    figure;
    gplotmap(W, [v2, v3], map_partition);
    title(['Spectral Drawing (v2, v3): ' graphs{k}]);
    axis equal; axis off;
    drawnow;
end

