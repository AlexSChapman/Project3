function res = MarsFlow(~, S)
L_D = .24; %lift-drag ratio

%State Variables
x = S(1);       %m
y = S(2);       %m
V_x = S(3);     %m/s
V_y = S(4);     %m/s

%Parameters
m = 2401 + 899; %Mass (kilograms) (EDL, Rover)
g = forceGravityMars(m, y); %Gravity (m/s^2)
p = marsAtmosphere(y); %Density of Air (kg/m^3)
C_d = 1.5; %Coefficient of Drag
A = 2.25^2 * pi; %Cross-sectional area (m^2)

Fgx = 0;        %kg m / s^2
Fgy = g;   %kg m / s^2

Fdx = -1/2.*C_d.*p.*A.*V_x.*sqrt(V_x.^2 + V_y.^2); % kg m / s^2
Fdy = -1/2.*C_d.*p.*A.*V_y.*sqrt(V_x.^2 + V_y.^2); % kg m / s^2

aOT = 90 - atand(V_y / V_x);
FLift = L_D * sqrt(Fdx.^2 + Fdy.^2);

Flx = cosd(aOT) * FLift;
Fly = sind(aOT) * FLift;

Fx = Fdx - Fgx + Flx; %kg m / s^2
Fy = Fdy - Fgy + Fly; %kg m / s^2

dxdt = V_x; %m / s
dydt = V_y; %m / s

dVxdt = Fx ./ m; %m / s^2
dVydt = Fy ./ m; %m / s^2

res =  [dxdt; dydt; dVxdt; dVydt];
end
