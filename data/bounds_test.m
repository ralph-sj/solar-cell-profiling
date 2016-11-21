intervals = 5;
i = 1:intervals;
range = floor((max(light)-min(light)/intervals)); % light range per interval

lower_bound = i*(max(light)-min(light))/intervals;
upper_bound = (i+1)*(max(light)-min(light))/intervals;

for iy = 1:intervals;
    ix = find (and((light<upper_bound(iy)),(light>=lower_bound(iy))));    % finds light values within that range
    p_av(iy) = mean(Power(ix));
    l_av(iy) = (lower_bound(iy)+upper_bound(iy))/2;
end

hold on
plot(l_av,p_av, 'r*')
hold off