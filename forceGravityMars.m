function gravitationalForce = forceGravityMars(m1, h)
%Precondition: m1 in kg, h in meters from the surface of Mars
%Postcondition: Gravitational attraction in Newtons
radiusMars = 3390000; %m
massMars = 6.39e23; %kg
G = 6.66e-11;
R = h + radiusMars;

gravitationalForce = G * m1 * massMars / (R^2);
end