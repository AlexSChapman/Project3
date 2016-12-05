function [K,Q,E] = calcHeatsMk2(Times, Y, VELOCITY, specificHeat)
%PostCOndition: heats in Kelvin over time
EMISSIVITY = .8;
RADIUS = 2.25; %meters
m = 2401 + 899; %Mass (kilograms) (EDL, Rover)
thermalStock = 250 * m * specificHeat;

gravitationalEnergy = Y(1) * forceGravityMars(m, Y(1));
kineticEnergy = 1/2 * m * VELOCITY(1)^2;
Ui = gravitationalEnergy + kineticEnergy;
Temperatures = zeros(1,length(Times));
qVals = zeros(1,length(Times));
eVals = zeros(1,length(Times));
for i = 2:length(Times)
    Temperatures(i) = thermalStock / (m  * specificHeat);
    dt = Times(i) - Times(i-1);
    Ug = Y(i) * forceGravityMars(m, Y(i));
    Uk = 1/2 * m * VELOCITY(i)^2;
    
    Uf = (Ug + Uk);
    
    E = 5.67E-8 * EMISSIVITY * (Temperatures(i)- marsAtmosphere(Y(i)))^4;
    E = E*pi*RADIUS^2*5 * dt;
    Udiff = (Ui - Uf)*.4;
    qVals(i) = Udiff;
    
    thermalStock = thermalStock + Udiff - E;
    Ui = Uf;
    eVals(i) = E;
end
K = Temperatures;
Q = qVals;
E = eVals;
end