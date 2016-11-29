function [K,Q,E] = calcHeats(Times, Y, VELOCITY, specificHeat)
%PostCOndition: heats in Kelvin over time
EMISSIVITY = .8;
RADIUS = 2.25; %meters
m = 2401 + 899; %Mass (kilograms) (EDL, Rover)
thermalStock = 283 * m * specificHeat;

% gravitationalEnergy = Y(1) * forceGravityMars(m, Y(1));
% kineticEnergy = 1/2 * m * VELOCITY(1)^2;
%Ui = gravitationalEnergy + kineticEnergy;
Temperatures = zeros(length(Times));
qVals = zeros(length(Times));
eVals = zeros(length(Times));

for i = 2:length(Times)
    Temperatures(i) = thermalStock / (m  * specificHeat);
    dt = Times(i) - Times(i-1);
    
    %     Ug = Y(i) * forceGravityMars(m, Y(i));
    %     Uk = 1/2 * m * VELOCITY(i)^2;
    %
    %     Uf = Ug + Uk;
    %
    %     Udiff = Ui - Uf;
    %     thermalStock = thermalStock + Udiff;
    
    qdot = 1.83E-4 * VELOCITY(i)^3*sqrt(marsAtmosphericDensity(Y(i))/RADIUS); %W / m^2)
    qVals(i) = qdot;
    E = 5.67E-8 * EMISSIVITY * Temperatures(i)^4;
    eVals(i) = E;
    SA = pi*RADIUS^2;
    change = (qdot*SA)*dt;
    thermalStock = thermalStock + change;
    
end
K = Temperatures;
Q = qVals;
E = eVals;
end