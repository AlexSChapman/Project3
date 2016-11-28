function testAtmosphereModel()
altitudes = linspace(300000, 0, 1000);
altitudes = altitudes(:);
densities = altitudes;
%densities = densities(:);

for i = 1:length(altitudes)
    densities(i) = marsAtmosphericDensity(altitudes(i));
end

disp(altitudes)
disp('Densities');
disp(densities)

T = table(altitudes, densities);
disp(T);

plot(altitudes./1000, densities);
ylabel('Density (kg / m^3)')
xlabel('Height (km)')
ylim([0 7E-4]);

end