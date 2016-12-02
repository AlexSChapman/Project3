function [K,Q,E,DT] = calcHeats(Times, Y, VELOCITY, specificHeat)
%PostCOndition: heats in Kelvin over time
EMISSIVITY = .8;
RADIUS = 2.25; %meters
m = 2401 + 899; %Mass (kilograms) (EDL, Rover)
thermalStock = 250 * m * specificHeat;

% gravitationalEnergy = Y(1) * forceGravityMars(m, Y(1));
% kineticEnergy = 1/2 * m * VELOCITY(1)^2;
%Ui = gravitationalEnergy + kineticEnergy;
Temperatures = zeros(length(Times));
qVals = zeros(length(Times));
eVals = zeros(length(Times));
dts = zeros(length(Times));
for i = 2:length(Times)
    %Temperatures(i) = thermalStock / (m  * specificHeat);
    outsideTemperature = marsAtmosphere(Y(i));
    Temperatures(i) = marsAtmosphere(Y(i));
    dt = Times(i) - Times(i-1);
    dts(i) = dt;

%    qVals(i) = qdot;
    
%     E = 5.67E-8 * EMISSIVITY * Temperatures(i)^4;
%     eVals(i) = E;
%     SA = pi*RADIUS^2;
%     change = (qdot*SA)*dt;
%     thermalStock = thermalStock + change;
    
end
K = Temperatures;
Q = qVals;
E = eVals;
DT = dts;
end