function run()
angles = -85:1:0;
Velocity = 18360 * 1000 / 60 / 60;
MaxTemp = zeros(1,length(angles));
MaxAcc = zeros(1,length(angles));
Vf = zeros(1,length(angles));
dX = zeros(1,length(angles));
C_T = 100;
C_A = 100;
C_Vf = 200;
C_x = 500 / 100;

for i = 1:length(angles)
    disp([angles(i)]);
    [MaxTemp(i), MaxAcc(i),Vf(i),dX(i)] = BaseScript(angles(i),Velocity,0);
    Vf(i) = Vf(i) *  0.0740;
end

% hold on
% plot(angles, MaxTemp);



p = polyfit(angles,MaxTemp,15);
nTemp = polyval(p,angles);
plot(angles, nTemp,'Linewidth',2);
xlabel('Angle from Horizontal (degrees)');
ylabel('Max Temperature (degrees Celcius)');
title('Temperature');

figure()
% hold on
% plot(angles,MaxAcc, 'b');

hold on
line([-90 0],[15*9.81 15*9.81]);
w = polyfit(angles,MaxAcc,15);
nAcc = polyval(w,angles);
for i = 1:length(nAcc)
    if(nAcc(i) > 9.81 * 15)
        nAcc(i) = 0;
    end
end
plot(angles, nAcc,'r','Linewidth',2);
xlabel('Angle from Horizontal (degrees)');
ylabel('Max Acceleration (m/s^2)');
title('Acceleration');
figure()

hold on
line([-90 0],[15*9.81 15*9.81]);
for i = 1:length(Vf)
    if(Vf(i) > 9.81 * 15)
        Vf(i) = 0;
    end
end
 plot(angles,Vf,'Linewidth',2);
xlabel('Angle from Horizontal (degrees)');
ylabel('Acceleration Caused by Parachute Opening (m/s^2)');
title('Parachute Acceleration');
figure()

plot(angles,dX,'Linewidth',2);
xlabel('Angle from Horizontal (degrees)');
ylabel('horizontal Displacement (m)');
title('horizontalDisplacement');
figure()

hold on
quantity = MaxTemp.*MaxAcc.*Vf.*dX;
% plot(angles, quantity,'b');
nAcc = nAcc .* C_A;
nTemp = nTemp .* C_T;
Vf = Vf .* C_Vf;
dX = dX .* C_x;
survivability = nAcc.*Vf.*(nTemp+dX);
for(i = 1:length(survivability))
    if(survivability(i) ==0)
        survivability(i) = NaN;
    end
end
plot(angles, survivability,'r','Linewidth',2);

title('Product Plot')
xlabel('Angle from Horizontal (degrees)');
end