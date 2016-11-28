function res = BaseScript()
duration = 7 * 60; %seconds

theta = -16; %degrees
Vi = 18360 * 1000 / 60 / 60; %m / s (kmps in m/s)

x = 0;  %m
y = 129 * 1000;  %m

Vx = cosd(theta) * Vi;   %m / s
Vy = sind(theta) * Vi;   %m / s

S = [x, y, Vx, Vy];

options = odeset('Events', @events);
[Times, Vals] = ode45(@MarsFlow, [0 duration] , S, options);

%plot(Times, Vals)
X = Vals(:,1);
Y = Vals(:,2);
DX = Vals(:,3);
DY = Vals(:,4);
VELOCITY = sqrt(DX.^2 + DY.^2);
ENERGY = 0.5 * VELOCITY.^2;
ENERGY_0 = 0.5 * 5100^2;
ERatio = ENERGY/ENERGY_0;

subplot(3,1,1);plot(Times,DY./1000);
grid on;
ylabel('Y-Speed (km/s)')
xlabel('Time (s)')

subplot(3,1,2);plot(Times,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('Time (s)')

subplot(3,1,3);comet(X./1000,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('X (km)')

figure()

plot(VELOCITY./1000,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('Velocity (km / s)')


%subplot(4,1,4);plot(Times,DX./1000);
grid on;
ylabel('X-Speed (km/s)')
xlabel('Time (s)')

%disp(VELOCITY)
%disp(Times)
%disp(X)
%disp(Y)

T = table(Times, X./1000, Y, VELOCITY, ERatio*100);
disp(T);

    function [value, isterminal,direction] = events(~,input)
        height = input(2);
        value = height - 0;
        isterminal = 1;
        direction = 0;
    end

end
