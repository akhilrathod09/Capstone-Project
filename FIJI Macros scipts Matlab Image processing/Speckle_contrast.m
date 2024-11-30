clc;
clear all;
close all;

% Define the main directory containing the speckle images
image_dir = 'C:\Users\91897\Desktop\CP302\Speckle Images\C_4\Set2\Center';

% Number of files
num_files = 90;

% Initialize a 3D array to store image data
A = [];

% Load images and store them in the array
for i = 1:num_files
    % Construct the file name
    file_name = sprintf('T%d_0008.ascii.csv', i);
    %file_name = sprintf('T%d.ascii.csv', i);
    file_name = sprintf('T%d_0008.png', i);
    file_path = fullfile(image_dir, file_name);
    
    % Check if the file exists before trying to read it
    if isfile(file_path)
        % Read the CSV file
        data = readmatrix(file_path);
        % Store the data in the 3D array
        A(:,:,i) = data;
    else
        disp(['File not found: ', file_path]);
    end
end

% Plot a particular frame
figure(1);
imagesc(A(:,:,1));
colorbar;

% Remove extra area and create new sub-arrays for region of interest (ROI)
B = [];
for i = 1:num_files
    B(:,:,i) = A(400:1100, 600:1300, i); % Example for the corner region
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
