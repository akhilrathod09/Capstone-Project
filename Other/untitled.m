clc;
clear all;
close all;

% Define the main directory containing the speckle images
image_dir = 'C:\Users\91897\Desktop\CP302\Speckle Images\C_3\Set1\Corner';

% Number of files
num_files = 90;

% Initialize a 3D array to store image data
A = [];

% Load the first image to determine its size
file_name = sprintf('T%d_0008.png', 1);
file_path = fullfile(image_dir, file_name);
first_image = imread(file_path);
if size(first_image, 3) == 3
    first_image = rgb2gray(first_image);
end
first_image = double(first_image);

% Get the size of the first image
[image_rows, image_cols] = size(first_image);

% Initialize a 3D array with the size of the first image
A = zeros(image_rows, image_cols, num_files);

% Load images and store them in the array, resizing as necessary
for i = 1:num_files
    % Construct the file name
    file_name = sprintf('T%d_0008.png', i);
    file_path = fullfile(image_dir, file_name);
    
    % Check if the file exists before trying to read it
    if isfile(file_path)
        % Read the image file (since it's .png)
        data = imread(file_path);
        
        % Convert the image to grayscale if it's not already
        if size(data, 3) == 3  % if it's an RGB image
            data = rgb2gray(data);
        end
        % Convert the grayscale image to double precision for calculations
        data = double(data);
        
        % Resize the image to match the size of the first image
        data = imresize(data, [image_rows, image_cols]);
        
        % Store the resized data in the 3D array
        A(:,:,i) = data;
    else
        disp(['File not found: ', file_path]);
    end
end

% Plot a particular frame
figure(1);
imagesc(A(:,:,1));
colorbar;

% Define valid region of interest (ROI) indices
% Ensure the indices are within the image size limits
roi_row_start = max(1, 400);
roi_row_end = min(image_rows, 1100);
roi_col_start = max(1, 600);
roi_col_end = min(image_cols, 1300);

% Remove extra area and create new sub-arrays for region of interest (ROI)
B = [];
for i = 1:num_files
    B(:,:,i) = A(roi_row_start:roi_row_end, roi_col_start:roi_col_end, i);
end

% Display the first frame of the ROI
figure(2);
imagesc(B(:,:,1));
colorbar;

% Speckle contrast calculation
S = zeros(1, num_files);
mean_intensity = zeros(1, num_files);
con = zeros(1, num_files);

for k = 1:num_files
    % Calculate standard deviation manually
    S(k) = sqrt(mean((B(:,:,k) - mean(B(:,:,k), 'all')).^2, 'all'));
    % Calculate mean intensity
    mean_intensity(k) = mean(B(:,:,k), 'all');
    % Speckle contrast = std. deviation / mean intensity
    con(k) = S(k) / mean_intensity(k);
end

disp('Speckle contrast values:');
disp(con);
disp('Mean speckle contrast:');
disp(mean(con));

% Define the time array for plotting
time = 0:1:89; % Adjusted to match the number of files (90 in total)

hfig = figure; % Save the figure handle in a variable

% Plot the speckle contrast
plot(time, con, 'LineWidth', 1.5, 'DisplayName', 'Speckle contrast');
xlabel('Time (min)', 'FontSize', 12);
ylabel('Speckle Contrast', 'FontSize', 12);
title('Speckle Contrast Over Time');
grid on;

% Save the figure
fname = 'Speckle_contrast_C_Center';
saveas(hfig, [fname, '.png']);

% Save the contrast values to a CSV file
csvwrite('Speckle_contrast_values.csv', con);
