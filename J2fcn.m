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

%% constants
% sidereal day is 23 hours, 56 minutes, 4.0916 seconds or 23.9344699 hours
stperut = 1.00273790935;    % siderial time = stperut * universal time  
W_EARTH_ROT = 2*pi/(23.9344699*60*60);   % rotation angular velocity of earth, SI
Re = 6378164 + 600000;    % Earth radius + Height of sat
mu=6.673e-11*5.9742e24;    % G*M_earth
J2 = 1.08263*10^-3;   % dimensionless constant

%%
% ut_sec = (today - equinox)*24*60*60 + t; % universal time vector in sec
% for the time being ut_sec = t
ut_sec =t
st_sec = stperut*ut_sec;    % sidereal time vector in sec
 
 phi = st_sec*W_EARTH_ROT;            % sidereal time vector in rad
 
% TEI = [ cos(phi) sin(phi) 0;
%        -sin(phi) cos(phi) 0;
%         0        0        1];
% TIE = TEI'    
%%

t
xp = zeros(6,1);
r = sqrt((x(1))^2+ (x(3))^2+ (x(5))^2 )
ax =  -(mu/r^3)*(x(1))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
ay = -(mu/r^3)*(x(3))*(1+(3/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
az =  -(mu/r^3)*(x(5))*(1+(9/2)*J2*Re^2/r^2 - (15/2)*J2*Re^2*(x(5))^2/r^4);
% this is  in ECEF frame...have to convert in ECI frame 
xp(1) =  x(2);
xp(2) = ax*cos(phi)-ay*sin(phi);

xp(3) =  x(4);
xp(4) = ax*sin(phi)+ay*sin(phi);
xp(5) =  x(6);
xp(6) = az;


%%
%[xp(1), xp(3),xp(5)] = TIE*[xp(1) ,xp(3), xp(5)]';
%[xp(2) xp(4) xp(6)]'= TIE*[xp(2) xp(4) xp(6)]';
%[xp(1), xp(3),xp(5)]

end

