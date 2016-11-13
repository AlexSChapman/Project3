function density = marsAtmosphere(h)
%Precondition: altitude above the surface in m
%Postcondition: atmoshperic density in kg m^3
if h >= 7000
    T = -23.4 -.00222 * h; %Celcius
    p = .699 * exp(-.00009 * h); %K-pa
else
    T = -31 -.000998 * h;
    p = .699 * exp(-.00009 * h);
end
density = p / (.1921 * (T + 237.15));
if h > 80000
    density = 0; %gets rid of irregular spike
end
end