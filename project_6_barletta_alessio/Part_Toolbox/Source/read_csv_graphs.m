% Script to load .csv lists of adjacency matrices and the corresponding 
% coordinates. 
% The resulting graphs should be visualized and saved in a .csv file.
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

addpaths_GP;

countries = {'CH', 'GB', 'CL', 'GR', 'NO', 'RU', 'VN'};

for k = 1:length(countries)
    % Steps
    % 1. Load the .csv files
    data_path = fullfile(fileparts(fileparts(mfilename('fullpath'))), "Datasets", "Countries_Meshes", "csv") + filesep;

    pattern_adj = data_path + countries{k} + "-*-adj.csv";
    pattern_coords = data_path + countries{k} + "-*-pts.csv";
    
    info_file_adj = dir(pattern_adj);
    info_file_pts = dir(pattern_coords);
    
    if isempty(info_file_adj) || isempty(info_file_pts)
        error("no file found");
    end
    
    filename_adj = fullfile(info_file_adj(1).folder, info_file_adj(1).name);
    filename_coords = fullfile(info_file_pts(1).folder, info_file_pts(1).name);

    graph_data = readmatrix(filename_adj);
    coordinates = readmatrix(filename_coords);
    % 2. Construct the adjaceny matrix (NxN).
    mat_size = size(coordinates, 1);
    i = graph_data(:, 1);
    j = graph_data(:, 2);
    mat = sparse(i, j, 1, mat_size, mat_size);
    
    if ~issymmetric(mat)
        mat = (mat + transpose(mat)) / 2;
    end
    
    
    % 3. Visualize the resulting graphs
    figure;
    gplot(mat, coordinates)
    % 4. Save the resulting graphs
    output_path = "Datasets/Countries_mat/";
    
    if ~exist(output_path, 'dir')
        mkdir(output_path);
    end
    
    
    output_filename = output_path + countries{k} + "_graph.mat";
    save(output_filename, 'mat', 'coordinates');
end


% Example of the desired graph format for CH

%load Swiss_graph.mat
%W      = CH_adj;
%coords = CH_coords;   
%whos

%figure;
%gplotg(W,coords);
