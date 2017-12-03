function xdot = J2fcn( t,x)
% x = [ x0 y0 z0 vx0 vy0 vz0 ]
 Re = 6378164;    % Earth radius + Height of sat
%mu=6.673e-11*5.9742e24;    % G*M_earth
 mu = 6.673e-11*5.9742e24;
 J2 = 1.08263*10^-3;   % dimensionless constant
 xdot = zeros(6,1);
 r = sqrt((x(1))^2+ (x(2))^2+ (x(3))^2 );  %4
 r2 = r^2;
 r3 = r2*r;
 
 A1 = -mu/r3;
 A2 = 1.5*J2*Re^2/r2;
 A3 = 3*A2;
 A4 = 5*A2*(x(3)^2)/r2;
 
 xdot(4) = A1*x(1)*(1+A2-A4);
 xdot(5) = A1*x(2)*(1+A2-A4);
 xdot(6) = A1*x(3)*(1+A3-A4);
 xdot(1) = x(4);   
 xdot(2) = x(5);
 xdot(3) = x(6);
% ax =  -(mu/r^3)*(x(1))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(3))^2/r^4);   %% 1 2(1 2 3)  =9   
% ay = -(mu/r^3)*(x(2))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(3))^2/r^4);
% az =  -(mu/r^3)*(x(3))*(1+(9/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(3))^2/r^4);

end

