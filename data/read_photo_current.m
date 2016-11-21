close all
clear

%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-16.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/11/17 11:36:52

%% Initialize variables.
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-16.txt';
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-17'; %16.txt';
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-18.dat';

delimiter = ',';

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
date = dataArray{:, 1};
light = dataArray{:, 2};
current = dataArray{:, 3};
voltage = dataArray{:, 4};


%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

%% CALCULATE
Time = (date-date(1)) * 24; % convert to hours from start
StartTime = datestr(date(1)) 
Power = (current .* voltage)/1e6;
Impedance = voltage ./ current;

% time
figure
subplot(2,2,1)
plot(Time, current, '.');
ylabel('Current (mA)')
xlabel('Time (hours)');

subplot(2,2,2)
plot(Time, voltage, '.');
ylabel('Voltage (mV)')
xlabel('Time (hours)');

subplot(2,2,3)
plot(Time, Impedance, '.');
ylabel('Impedance (\Omega)')
xlabel('Time (hours)');

subplot(2,2,4)
plot(Time, light, '.');
ylabel('Light (lux)')
xlabel('Time (hours)');

% light
figure
subplot(3,1,1)
plot(light,current, '.');
ylabel('Current (mA)')
set(gca,...
'XTickLabel','')
set(gca, 'XTick', []);

subplot(3,1,2)
plot(light,voltage, '.');
ylabel('Voltage (mV)')
set(gca,...
'XTickLabel','')
set(gca, 'XTick', []);

subplot(3,1,3)
plot(light,Impedance, '.');
xlabel('Light (lux)');
ylabel('Impedance (\Omega)')


figure
plot(light, Power) %, '.')
xlabel('Light (lux)');
ylabel('Power (W)')