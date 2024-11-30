clc;
clear all;
close all;

% Define the main directory containing the speckle images
image_dir = 'C:\Users\91897\Desktop\CP302\Speckle Images\C_1\Set2\Corner';

% Number of files
num_files =90;

% Initialize an array to store mean intensity values
mean_intensity_values = zeros(num_files, 1);
% Loop through each file and calculate the mean intensity

for i = 1:num_files
    % Construct the file name
    %file_name = sprintf('T%d_0008.ascii.csv', i);
    file_name = sprintf('T%d.ascii.csv', i);

    file_path = fullfile(image_dir, file_name);
    
             % Read the CSV file
    data = readmatrix(file_path);
    % Calculate the mean intensity of the ROI
    mean_intensity = mean(data(:));
    
    % Store the mean intensity value
    mean_intensity_values(i) = mean_intensity;
end
   
% Display the mean intensity values
disp('Mean intensity values:');
disp(mean_intensity_values);

hfig = figure;  % save the figure handle in a variable
% Optional: Plot the mean intensity value

plot(1:num_files, mean_intensity_values, '-o', 'LineWidth', 2);
xlim([0 90])
% ylim([-0.4 0.8])
% xlabel('Files','FontSize',13);
xlabel('Time(min)');
ylabel('Mean Intensity');
% ylabel('Mean Intensity','FontSize',13);


fname = 'mean_intensity_C_Center';

picturewidth = 20; % set this parameter and keep it forever
hw_ratio = 0.65; % feel free to play with this ratio
set(findall(hfig,'-property','FontSize'),'FontSize',17) % adjust fontsize to your document

set(findall(hfig,'-property','Box'),'Box','on') % optional
set(findall(hfig,'-property','Interpreter'),'Interpreter','none') 
set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter')
set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
pos = get(hfig,'Position');
set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
% print(hfig,fname,'-dpdf','-vector','-fillpage')
print(hfig,fname,'-dpng','-vector')
% saveas(gcf,'mean_intensity_C_Corner.png');
