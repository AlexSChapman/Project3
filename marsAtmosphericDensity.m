function density = marsAtmosphericDensity(Alt)
Alt = Alt / 1000;
p = .699*exp(-.00009*((Alt-6)*1000));
density = p/((0.1921)*(273.1));
end