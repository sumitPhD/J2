
pos = [6524.834,0,0]';
vel = [0,7.81599286557539,0]';
mu = 6.673e-11*5.9742e24;
%Convert to keplerian orbital elements
[a,e,i,O,o,nu,truLon,argLat,lonPer,p] =rv2orb(pos,vel,mu);


Re = 6378164 + 600000;    % Earth radius + Height of sat
p=Re/1000;   %Semilatus Rectum% (km)
e = 0 ; % eccentricity
i = 97.7925*pi/180; %inclination radian
O =  184.168*pi/180; %right ascention of ascending node
o =0; % argument of perigee
nu =20; % true anamoly in rad


mu = 6.673e-11*5.9742e24;

 [r,v] = orb2rv(p,e,i,O,o,nu)
 

%% Initial condition
% time step
t0 = 0;
tf =1;
% Initial position
x10 =1;
x20 =0;
x30 = 2;
% initial velocity
v10 =0;
v20 =0;
v30 =0;

%% ode and plot
[t,x] = ode45('J2fcn', [t0,tf], [x10 v10 x20 v20 x30 v30]);
plot(t,x(:,1));

%% from modTLE sgp model
n0 = 2*pi*meanMo/1440; % Mean motion (rad/min)
   %0= e0 = orbEcc; % Eccentricity (0.0<=e0>=1.0)       
    i0 = pi*orbInc/180; % Inclination (rad)
    M0 = pi*meanAno/180; % Mean anomaly (rad)
    w0 = pi*argPer/180; % Argument of perigee (rad)
    Ohm0 = pi*rghtAsc/180; % Right ascension of the ascending node (rad)
    dn0 = 2*2*pi*SGPdragp1/(1440^2); % First time derivative of mean motion(rad/min^2)
    ddn0 = 6*2*pi*SGPdragp2/(1440^3); % Second time derivative of mean motion (rad/min^3)
    Bstar = SGP4dragp; % SGP4 type drag coefficient
    % Mean year (400 year period) in days:
    meanYearDays = (400*365 + 4 * (100/4 - 1) + 1) / 400;
    % Time of epoch (since y2k)
    t0 = (EpYear*meanYearDays + EpJD + EpTime)*1440;
    modTLE = [t0 dn0 ddn0 Bstar i0 Ohm0 e0 w0 M0 n0 revNo];
    
    meanMo = sqrt(mu/R_e^3)*86400/2/pi; % w_SAT in rev/day
orbEcc = 0;     % 0 for circular orbit
orbInc = 97.7925;%98.1873; % constant
argPer = 0;     % 0 for circular orbit
meanAno = - argPer;%88.4025;        
rghtAsc = 184.168;
SGPdragp1 = -7.86e-006;
SGPdragp2 = 0;
SGP4dragp = -3.5889e-005;
EpYear = mod(sime(1),100);
EpJD = s_DOY;
EpTime = s_SEC/86400;
revNo = 1;
