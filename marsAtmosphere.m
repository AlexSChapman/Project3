function T = marsAtmosphere(h)
%Precondition: altitude above the surface in m
%Postcondition: atmoshperic temperature in Celcius

if h > 7000
    T = -23.4 - (.00222 * h); %Celcius
    p = abs(.699 * exp(-.00009 * h)); %K-pa
end

if h < 7000
    T = -31 - (.000998 * h);
    p = .699 * exp(-.00009 * h);
end

density = p / (.1921 * (T + 273.1));

end