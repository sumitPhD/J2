function xp = J2fcn( t,x )
% calling of this function is made on J2.m
%ref https://ocw.tudelft.nl/wp-content/uploads/AE2104-Orbital-Mechanics-Slides_8.pdf
% for calculation of acceleration above ref was useful

%J2FCN Summary of this function goes here
%   Detailed explanation goes here

%state matrix explained
%xdot = x1; x1dot = x2
%[x1dot y1dot z1dot x2dot y2dot z2dot]'= [0 0 0 1 0 0 ;0 0 0 0 1 0; 0 0 0 0 0 1; Matrix] + [x1 y1 z1 x2 y2 z2];

% initial condition as [postionX0  velocityXdot0 postionY0  velocityYdot0 postionZ0 velocityZdot0 ]
ut_sec = t; % universal time in sec
stperut = 1.00273790935;    % siderial time = stperut * universal time  
st_sec = stperut*ut_sec;    % sidereal time in sec
W_EARTH_ROT = 2*pi/86400;
phi = st_sec*W_EARTH_ROT;            % sidereal time in rad

Re = 6378164;    % Earth radius + Height of sat
mu=6.673e-11*5.9742e24;    % G*M_earth
 J2 = 0;%1.08263*10^-3;   % dimensionless constant
t;
xp = zeros(6,1);
r = sqrt((x(1))^2+ (x(3))^2+ (x(5))^2 );
%ax =  -(mu/r^3)*(x(1))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
%ay = -(mu/r^3)*(x(3))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
%az =  -(mu/r^3)*(x(5))*(1+(9/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
%a= sqrt(ax^2+ay^2+az^2);
% this is  in ECEF frame...have to convert in ECI frame 

ax_n = -8*(10^12)*x(1)/(r^3);
ay_n = -8*(10^12)*x(3)/(r^3);
az_n = -8*(10^12)*x(5)/(r^3);

xp(1) =  x(2);
xp(2) = ax_n;
xp(3) =  x(4);
xp(4) = ay_n;
xp(5) =  x(6);
xp(6) = az_n;
%xp-[x(2) ax x(4) ay x(6) az]'

% xp(2) = ax*cos(phi)+ay*sin(phi);
% xp(4) = -ax*sin(phi)+ay*cos(phi);

%%
%[xp(1), xp(3),xp(5)] = TIE*[xp(1) ,xp(3), xp(5)]';
%[xp(2) xp(4) xp(6)]'= TIE*[xp(2) xp(4) xp(6)]';
%[xp(1), xp(3),xp(5)]


end

