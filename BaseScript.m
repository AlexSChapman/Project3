function res = BaseScript()
duration = 7 * 60; %seconds

theta = 0; %degrees
Vi = 18360 * 1000 / 60 / 60 %m / s (kmps in m/s)

x = 0;  %m
y = 129 * 1000;  %m

Vx = cosd(theta) * Vi;   %m / s
Vy = sind(theta) * Vi;   %m / s

S = [x, y, Vx, Vy];

options = odeset('Events', @events);
[Times, Vals, eventTimes] = ode45(@MarsFlow,0:duration, S, options);

%plot(Times, Vals)
X = Vals(:,1);
Y = Vals(:,2);
DX = Vals(:,3);
DY = Vals(:,4);
VELOCITY = sqrt(DX.^2 + DY.^2); 

subplot(4,1,1);plot(Times,DY./1000);
grid on;
ylabel('Speed (km/s)')
xlabel('Time (s)')

subplot(4,1,2);plot(Times,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('Time (s)')

subplot(4,1,3);plot(VELOCITY./1000,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('Velocity (km / s)')

subplot(4,1,4);plot(X./1000,Y./1000);
grid on;
ylabel('Altitude (km)')
xlabel('X (km)')


    function [value, isterminal,direction] = events(~,input)
        distance = input(1);
        height = input(2);
        value = height - 0;
        isterminal = 1;
        direction = 0;
    end

end
