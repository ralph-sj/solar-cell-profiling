clear lower_bound upper_bound p_av l_av

step_size = 25; % step size (in lux)
min_light = 0; % minimum lux
max_light = floor(max(light)/step_size) * step_size; % the maximum light level as an integer multiple of the step size
intervals = max_light/step_size; % number of itervals
i = 1:intervals;

lower_bound = min_light + (i-1)*(max_light-min_light)/intervals;
upper_bound = min_light + i*(max_light-min_light)/intervals;

% exclude -infinity answers (only applicable for log functions) replace
% with NaN
II = find(Power == -Inf);
Power(II) = NaN;
light(II)=NaN;
clear II

for iy = 1:intervals;
    ix = find (and((light<upper_bound(iy)),(light>=lower_bound(iy))));    % finds light values within that range
    p_av(iy) = (max(Power(ix))+min(Power(ix)))/2;
    l_av(iy) = (lower_bound(iy)+upper_bound(iy))/2;
end

hold on
plot(l_av,p_av, 'r*')
hold off

% save to workspace
save(file, 'l_av', 'p_av');