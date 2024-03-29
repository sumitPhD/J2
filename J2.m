tic
%% Initial condition
% time step
t0 = 0;
tstep = 0.1;
tf =240e3;

%% Initial position (ref http://www.celestrak.com/NORAD/documentation/spacetrk.pdf)
% x10 =-7.061909962477235e+06;
% x20 =-5.167452270138207e+05;
% x30 = -1.465993415673929e+04;
% % initial velocity
% v10 =-85.445362976044650;
% v20 =1.064510485883730e+03;
% v30 =7.427298812052643e+03;
 Re = 6378164; % in m
% x10 = 2328.97*10^3; x20 =-5995.220*10^3; x30 = 1719.97*10^3;
% v10 =2.912*10^3; v20=-0.9816*10^3; v30 =-7.09*10^3;
mu = 6.673e-11*5.9742e24;

% x10 = 35311.8487144841; x20 =5949798.79003529; x30 =  -3862353.79845571;
% v10 =1249.40341899082; v20=-3998.67838403978; v30 =-6197.75273442587;
% [35311.8487144841;5949798.79003529;-3862353.79845571;1249.40341899082;-3998.67838403978;-6197.75273442587]
%[0;642350.319267918;-7024468.72331046;-70287.2023970021;-2336.95884075122;-245.549805288418;7147.01555055971]
% (v10^2+v20^2+v30^2)/sqrt(x10^2+x20^2+x30^2)
% (v10*x10+v20*x20+v30*x30)/(sqrt(v10^2+v20^2+v30^2)*sqrt(x10^2+x20^2+x30^2))
% [35311.8487144841;5949798.79003529;-3862353.79845571;1249.40341899082;-3998.67838403978;-6197.75273442587]
%% ode and plot
% opts = odeset('RelTol',1e-3,'AbsTol',1e-5);
% [t,x] = ode45('J2fcn', [t0:tstep:  tf], [x10 v10 x20 v20 x30 v30]);
h = tstep; 
y = zeros(7,tf/h+1);

i = 1;
% state vector y = [t x0 y0 z0 vx0 vy0 vz0]
y(:,1) = [0;SGP_1(2:7,1)];
for j =0:h:tf-h
    
    k1= J2fcn(y(1,i), y(2:7,i));
    k2= J2fcn(y(1,i)+h/2, y(2:7,i)+h*k1/2); % 3 
    k3= J2fcn(y(1,i) +h/2, y (2:7,i)+h*k2/2); %3
    k4= J2fcn(y(1,i)+h, y (2:7,i)+h*k3); %3
    
    y(2:7,i+1) = y(2:7,i)+ h/6 * (k1+2*k2 +2*k3 + k4); %6
    y(1,i+1) = y(1,i)+ h;  %1
    i= i+1;
   
end

toc

save y.mat
%J2_test_case = [[t0:tstep:tf]'; x(:,1); x(:,3);x(:,5);x(:,2);x(:,4);x(:,6)];
%rr = sqrt(y(2,:).*y(2,:)+y(3,:).*y(3,:)+y(4,:).*y(4,:));
% hold on 
% plot(t, y(2,:)/1000);
% plot(t, y(3,:)/1000);
% plot(t, y(4,:)/1000);
% plot(t, rr/1000);
% hold off
% 
% rr_sgp  = sqrt(SGP_test_case(2,:).*SGP_test_case(2,:)+SGP_test_case(3,:).*SGP_test_case(3,:)+SGP_test_case(4,:).*SGP_test_case(4,:));
% plot(rr_sgp);
% rr_diff = (rr_sgp -rr);
% plot(rr_diff);
