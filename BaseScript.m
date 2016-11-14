function res = BaseScript()
    
disp(forceGravityMars(4200, 1000))

altitudes = 1:100:1e10;
densities = altitudes;
for i = 1:length(altitudes)
%     altitudes(i) = forceGravityMars(2100,i);
    densities(i) = forceGravityMars(4200, i);
end

plot(altitudes, densities);
xlabel('Altitude (m)');
ylabel('Gravitational Attraction (N)')

end