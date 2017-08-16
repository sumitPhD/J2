%% Initial condition
% time step
t0 = 0;
tstep = 0.01;
tf =100000;
%%SGP 4 model's test case given in (test case is run in 360 minutes(6hr) of interval)
%%http://www.celestrak.com/NORAD/documentation/spacetrk.pdf page 80
%1 88888U 80275.98708465 .00073094 13844-3 66816-4 0 8
%2 88888 72.8435 115.9689 0086731 52.6988 110.5714 16.05824518 105

% taking initial position and velocity from the test case at t =0 and the
% J2.m and J2fcn run for 1440 minutes and checked with the test data given
% at 360 minutes of interval
%input is given in meters and meters/sec


% Orbital Parameters
%[r,v] = orb2rv(p,e,i,O,o,nu,truLon,argLat,lonPer,mu)
% Inputs: 
%{
p                                              %Semilatus Rectum (km)
e                                             %Eccentricity Magnitude(unitless)
i                                          % inclination (radians)
O                                              %Right Ascention of the ascending node(radians)
o                                           %Argument of perige% (radians)
nu                                            %True Anomaly(radians)
truLon                                        %True Longitude(radians)
argLat                                        %Argument of Latitude(radians)
lonPer                                        %Longitude of Periapse (radians)
mu                                            %Gravitational Constant 
%}
%% Initial position (ref http://www.celestrak.com/NORAD/documentation/spacetrk.pdf)
% x10 =-7.061909962477235e+06;
% x20 =-5.167452270138207e+05;
% x30 = -1.465993415673929e+04;
% % initial velocity
% v10 =-85.445362976044650;
% v20 =1.064510485883730e+03;
% v30 =7.427298812052643e+03;
 Re = 6378164;
% x10 = 2328.97*10^3; x20 =-5995.220*10^3; x30 = 1719.97*10^3;
% v10 =2.912*10^3; v20=-0.9816*10^3; v30 =-7.09*10^3;
mu = 6.673e-11*5.9742e24
x10 = Re+100000; x20 =0; x30 = 0;
v10 = 0; v20=sqrt(8*(10^12)/x10); v30 =0;
% (v10^2+v20^2+v30^2)/sqrt(x10^2+x20^2+x30^2)
% (v10*x10+v20*x20+v30*x30)/(sqrt(v10^2+v20^2+v30^2)*sqrt(x10^2+x20^2+x30^2))

%% ode and plot
[t,x] = ode45('J2fcn', [t0:tstep:tf], [x10 v10 x20 v20 x30 v30]);
 
%J2_test_case = [[t0:tstep:tf]'; x(:,1); x(:,3);x(:,5);x(:,2);x(:,4);x(:,6)];
rr = x(:,1).*x(:,1)+x(:,3).*x(:,3)+x(:,5).*x(:,5);
plot(t, rr(:)/1000);
%hold on 
% rrsgp = SGP_120k(2,1:length(t)).*SGP_120k(2,1:length(t))+  SGP_120k(3,1:length(t)).*SGP_120k(3,1:length(t))+  SGP_120k(4,1:length(t)).*SGP_120k(4,1:length(t)); 
% plot(t,rrsgp(:),'red');
%save J2_test_case.mat 