function res = calculateAccelerations(Times, Velocities)
res = zeros(1,length(Times));
for i = 2:length(Times)
    vf = Velocities(i);
    vi = Velocities(i-1);
    tf = Times(i);
    ti = Times(i-1);
    res(i) = (vf - vi) / (tf - ti);
end
end