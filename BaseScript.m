function [MaxTemp, MaxAcc, Vf, dX] = BaseScript(theta, Vi, plotFlag)
%Important criteria for survivability
%Acceleration
%Heating
%horizontal distance

duration = 7 * 60; %seconds
%TheoreticalMaxTemp 2203.15 K

C = 1884.06; %Specific Heat PICA (J / (kg *C))

%theta = -16; %degrees
%Vi = 18360 * 1000 / 60 / 60; %m / s (kmps in m/s)
%Vi = 21000 * 1000 / 60 / 60; %m / s (kmps in m/s)


x = 0;  %m
%y = 129 * 1000;  %m
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
ACCELERATIONS = abs(calculateAccelerations(Times, VELOCITY));
[TEMPERATURES, QVALS, EVALS] = calcHeatsMk2(Times, Y, VELOCITY, C);

MaxTemp = max(TEMPERATURES);
MaxAcc = max(ACCELERATIONS);
Vf = VELOCITY(end);
dX = X(end);

if(plotFlag == 1)
    
    w = table(TEMPERATURES(:,1), QVALS(:,1), EVALS(:,1));
    
    disp(w);
    disp('IMPORTANT');
    disp(max(QVALS));
    
    hold
    plot(Times, TEMPERATURES,'r');
    %plot(Times, QVALS(:,1),'b');
    %plot(Times, EVALS(:,1), 'black');
    % legend('temp','q');
    figure()
    
    hold on
    plot(Times, abs(ACCELERATIONS),'black','Linewidth', 2); %acceleration in m/s^2
    plot(Times, Y./1000, 'b','Linewidth', 2); %altitude in km
    plot(Times, VELOCITY./100,'r','Linewidth', 2); %Speed in 100m/s
    xlabel('Time (seconds)');
    ylabel('Acceleration (m/s^2) (black), AirSpeed (100m/s) (red), Altitude (km) (blue)');
    figure();
    
    subplot(4,1,1);plot(Times,DY./1000);
    grid on;
    ylabel('Y-Speed (km/s)')
    xlabel('Time (s)')
    
    subplot(4,1,2);plot(Times,DX./1000);
    grid on;
    ylabel('X-Speed (km/s)')
    xlabel('Time (s)')
    
    subplot(4,1,3);plot(Times,Y./1000);
    grid on;
    ylabel('Altitude (km)')
    xlabel('Time (s)')
    
    subplot(4,1,4);plot(X./1000,Y./1000);
    grid on;
    ylabel('Altitude (km)')
    xlabel('X (km)')
    
    figure()
    
    plot(VELOCITY./1000,Y./1000);
    grid on;
    ylabel('Altitude (km)')
    xlabel('Velocity (km / s)')
    set(gca,'ytick',[0 25 50 75 100 125 150])
    
    
    T = table(Times, X./1000, Y, VELOCITY, ERatio*100);
    disp(T);
end

  function [value, isterminal,direction] = events(~,input)
        height = input(2);
        value = height - 11000;
        isterminal = 1;
        direction = 0;
    end
end
