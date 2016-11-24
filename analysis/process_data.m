%% PROCESS_DATA
% This script reads in multiple files from different solar cells,
% calculates the summarised data and then then reloads the data.  A single
% light/power plot of all solar cell is then produced.

filestruct = {
    'AM-5610CAR',
    'AM-1417CA',
    'CBC-PV-01N',
    'KXOB22-04X3F',
    'AM-5412CAR'
    }; % solar cells to profile

for i = 1:length(filestruct)
    file = filestruct{i};
    read_photo_current_with_title
    bounds_test
end


clearvars -except filestruct
clc
colourstruct = {'b*','rs','c+','kd','g^'};
figure
xlabel('Light (lux)');
ylabel('Power, (\mu W)');
hold on

for i = 1:length(filestruct)
    filestringtoload = [filestruct{i}, '.mat'];
    load(filestringtoload);
    semilogy(l_av,p_av, colourstruct{i});
end
legend(filestruct)



hold off
