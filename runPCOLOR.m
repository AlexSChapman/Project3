function runPCOLOR()
angles = -85:1:0;
Vmax = 1.5*18360 * 1000 / 60 / 60;
Vmin = .5*18360 * 1000 / 60 / 60;
velocities = Vmin:100:Vmax;
MaxTemp = zeros(length(velocities),length(angles));
MaxAcc = zeros(length(velocities),length(angles));
Vf = zeros(length(velocities),length(angles));
dX = zeros(length(velocities),length(angles));

for i = 1:length(angles)
    
    for d = 1:length(velocities)
        disp([angles(i), velocities(d)]);
        [MaxTemp(d,i), MaxAcc(d,i),Vf(d,i),dX(d,i)] = BaseScript(angles(i),velocities(d),0);
    end
end
pcolor(MaxTemp);
colorbar
xlabel('Angle From Horizontal (degrees)');
ylabel('Velocity Entering Atmosphere');
ax = gca;

set(ax,'XTickLabel',[-75:10:20]);
set(ax, 'YTickLabel',Vmin:200:Vmax);
end