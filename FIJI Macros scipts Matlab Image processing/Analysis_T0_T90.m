clc
clear all;
close all;
% % % % To load To_0001.ascii.csv T10_0001ascii.csv file in loop%%%
for i = 0:90
    if i < 90
        filename = sprintf('T%d.ascii.csv', i+1);
        % filename = sprintf('T%d_0008.ascii.csv', i+1);
    else
        filename = sprintf('T%1d.ascii.csv', i);
        % filename = sprintf('T%1d_0008.ascii.csv', i);
    end
    % Check if the file exists before loading it
    if exist(filename, 'file')
        A(:,:,i+1) = load(filename);
    else
        fprintf('File not found: %s\n', filename);
    end
end
% 
% %%%%To plot a particular frame
figure(1)
imagesc(A(:,:,1))
%%% ...... remove extra area.........%%%
for i = 1:91
    % B(:,:,i) = A(850:949,750:849,i);     %%%% for center
    % B(:,:,i) = A(790:800,1090:1100,i); %%% corner
     B(:,:,i) = A(400:1100,600:1300,i);   %%% corner
end
% B = A(200:1300, 600:1800);
figure(2)
imagesc(B(:,:,1))


% Speckle constrast calculation
figure(3)
for k=1:91
S(k) = std2(B(:,:,k));        %%% std  deviation
mu(k) = mean(mean(B(:,:,k))); %%%% mean intensity
con(k) = S(k)./mu(k); %%% speckle constrast=std.deviation/mean intensity
end
disp(con)
mean(con)

time =0:1:90; %% minutes

hfig = figure;  % save the figure handle in a variable
% t = 0:0.02:10; x = t.*sin(2*pi*t)+ 2*rand(1,length(t)); % data
plot(time,con,'LineWidth',1.5,'DisplayName','Speckle contrast');
% xlabel('Time $t$ (min)','FontSize',12)
xlabel('Time (min)','FontSize',12)
ylabel('S','FontSize',12)
% saveas(gcf,'Speckle contrast_C_Center.png') 
fname = 'Speckle contrast_C_Center';

% picturewidth = 20; % set this parameter and keep it forever
% hw_ratio = 0.65; % feel free to play with this ratio
% set(findall(hfig,'-property','FontSize'),'FontSize',17) % adjust fontsize to your document
% 
% set(findall(hfig,'-property','Box'),'Box','on') % optional
% set(findall(hfig,'-property','Interpreter'),'Interpreter','latex') 
% set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
% set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
% pos = get(hfig,'Position');
% set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
% %print(hfig,fname,'-dpdf','-painters','-fillpage')
% print(hfig,fname,'-dpng','-vector')

