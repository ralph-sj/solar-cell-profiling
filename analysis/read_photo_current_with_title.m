%% START
close all
clear

%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-21.dat
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/11/21 09:13:14

%% Initialize variables.
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-21.dat';
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\IXYS KXOB22-04X3F.dat'
% filename = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\public\solar-cell-profiling\data\capture-2016-11-22';
%
% WINDOWS
filepath = 'C:\Users\Ralph S-J\Dropbox\02 UNIVERSITY\02 Technical\07 Instrumentation\private\data\';
% MAC
% filepath = '/Volumes/iMac Data/Documents/Dropbox/02 UNIVERSITY/02 Technical/07 Instrumentation/private/data/';


% file = 'AM-5610CAR';
% file = 'AM-1417CA';
% file = 'CBC-PV-01N';
% file = 'KXOB22-04X3F';
file = 'AM-5412CAR';
% file = 'KXOB22-12X1L'; % not yet profiled

% file = 'capture-2016-11-22'; % from AM-5610CAR.dat
file = 'capture-2016-11-22_1'; % AM-1417CA


filename = [filepath, file, '.dat'];

delimiter = ',';
startRow = 4;

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
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

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
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% CALCULATE
Time = (date-date(1)) * 24; % convert to hours from start
StartTime = datestr(date(1)) 
Power = current .* voltage/1e3;   % in uW (voltage is in mV)
Impedance = voltage ./ (current/1e6); % in Ohms

% time
figure
subplot(2,2,1)
plot(Time, current, '.');
ylabel('Current (\mu A)')
xlabel('Time (hours)');

subplot(2,2,2)
plot(Time, voltage, '.');
ylabel('Voltage (mV)')
xlabel('Time (hours)');

subplot(2,2,3)
plot(Time, light, '.');
ylabel('Light (lux)')
xlabel('Time (hours)');

subplot(2,2,4)
plot(Time, Power, '.');
ylabel('Power (\mu W)')
xlabel('Time (hours)');

% light
figure
subplot(2,1,1)
plot(light,current, '.');
ylabel('Current (\mu A)')
set(gca,...
'XTickLabel','')
set(gca, 'XTick', []);

subplot(2,1,2)
plot(light,voltage, '.');
ylabel('Voltage (mV)')
set(gca,...
'XTickLabel','')
set(gca, 'XTick', []);

% subplot(3,1,3)
% plot(light,Impedance, '.');
% xlabel('Light (lux)');
% ylabel('Impedance (\Omega)')


figure
plot(light, Power) %, '.')
xlabel('Light (lux)');
ylabel('Power (\mu W)')
title(file);