function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.

%  Add necessary paths
addpaths_GP;

% Graphs in question
graphs = {'luxembourg_osm', 'usroads', 'GR_graph', 'CH_graph', 'NO_graph', 'RU_graph', 'VN_graph'};

% Steps
% 1. Initialize the cases
cut_recursive = zeros(2, length(graphs));
cut_kway = zeros(2, length(graphs));

for i = 1:length(graphs)

    clear Problem A xy mat coordinates;

    load(graphs{i});
    if exist('Problem', 'var')
        A = Problem.A;
        if isfield(Problem, 'aux')
            xy = Problem.aux.coord;
        else
            xy = [];
        end
    elseif exist('mat', 'var')
        A = mat;
        xy = coordinates;
    end
    
% 2. Call metismex to
%     a) Recursively partition the graphs in 16 and 32 subsets.
    [part16_rec, edgecut16_rec] = metismex('PartGraphRecursive', A, 16);
    [part32_rec, edgecut32_rec] = metismex('PartGraphRecursive', A, 32);
    
    cut_recursive(1, i) = edgecut16_rec;
    cut_recursive(2, i) = edgecut32_rec;

%     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
    [part16_kway, edgecut16_kway] = metismex('PartGraphKway', A, 16);
    [part32_kway, edgecut32_kway] = metismex('PartGraphKway', A, 32);
    
    cut_kway(1, i) = edgecut16_kway;
    cut_kway(2, i) = edgecut32_kway;

% 3. Visualize the results for 32 partitions.
    if picture
        if strcmp(graphs{i}, 'usroads') || strcmp(graphs{i}, 'luxembourg_osm') || strcmp(graphs{i}, 'RU_graph')
            figure;
            gplotmap(A, xy, part32_rec);
            title(['Recursive Bisection 32: ' graphs{i}]);
            axis off; axis image;
            
            figure;
            gplotmap(A, xy, part32_kway);
            title(['Direct K-way 32: ' graphs{i}]);
            axis off; axis image;


        end
    end
end

end