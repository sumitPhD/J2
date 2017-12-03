clc
err = zeros(1,size(y,2));
r_j2 = err;
r_sgp = err;
angle = err;
for i = 1:size(y,2)
    r_j2(i) = norm(y(2:4,i),2);
    r_sgp(i) = norm(SGP_1(2:4,i),2);
    err(i) = norm((y(2:4,i)-SGP_1(2:4,i)),2);
    vdot = dot(y(2:4,i),SGP_1(2:4,i))/(r_j2(i)*r_sgp(i));
    angle(i) = acos(vdot)*180/pi; %angle between SGP and J2 vector
end
figure
plot(y(1,:),err);
xlabel('time (in seconds)')
ylabel('r_J2 - r_SGP (in meters )')
title('Difference between J2 and SGP radial vector')
figure
plot(y(1,:),angle);
xlabel('time (in seconds)')
ylabel('\theta')
title('Angle between J2 and SGP radial vector')
figure 
plot(y(1,:),r_j2)
hold on
plot(y(1,:),r_sgp)
xlabel('time (in seconds)')
ylabel('r in meters')
title('Absolute value of radius')
legend('J2','SGP')
hold off