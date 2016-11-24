%% find_outliers
% this script looks for certain values in the data that match certain
% anomolies i.e. that are outside of given range of power/light
% combinations.  These values can then be deleted (manually) from the data
% file.  This can be used to give a smoother profile.  For example, a light
% value of 175 lux there may be an outlying power value of 40 whereas all
% other point ro light = 175 are 100 or more.

light_level = 175; % find this from graph e.g. using data cursor
power_threshold = 45; % find this from graph e.g. using data cursor
ix = find(light==light_level); % find the indices of the data machting the light value of the outlying data point in the light aray
iy=find(Power(ix)<power_threshold) % find the indices in the power array that match the light condition AND the power condition
iz=ix(iy) % find the index of the array (of light or power) where the above condition is met
Power(iz) % dislay value to check
light(iz) % dislay value to check for file
current(iz) % dislay value to check for file