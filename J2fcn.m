function xp = J2fcn( t,x)

% initial condition as [postionX0  velocityXdot0 postionY0  velocityYdot0 postionZ0 velocityZdot0 ]
Re = 6378164;    % Earth radius + Height of sat
%mu=6.673e-11*5.9742e24;    % G*M_earth
mu = 6.673e-11*5.9742e24;
 J2 = 1.08263*10^-3;   % dimensionless constant
t;
xp = zeros(6,1);
 r = sqrt((x(1))^2+ (x(3))^2+ (x(5))^2 );  %4
ax =  -(mu/r^3)*(x(1))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);   %% 1 2(1 2 3)  =9   
ay = -(mu/r^3)*(x(3))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
az =  -(mu/r^3)*(x(5))*(1+(9/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
%a= sqrt(ax^2+ay^2+az^2);
% this is  in ECEF frame...have to convert in ECI frame 
% 
% ax_n = -mu*(1/(r^3))*x(1);
% ay_n = -mu*(1/(r^3))*x(3);
% az_n = -mu*(1/(r^3))*x(5);
xp(1) =  x(2);   %% 6
xp(2) = ax;
xp(3) =  x(4);
xp(4) = ay;
xp(5) =  x(6);
xp(6) = az;
end

