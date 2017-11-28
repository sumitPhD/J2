tic
%% Initial condition
% time step
t0 = 0;
tstep = 0.1;
tf =6000*100;  % 6*10^5 , 1 orbit - 6*10^3 

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
x10 = 2328966.08303380; x20 =-5995216.03827729; x30 =  1719978.73535898;
v10 =2911.10102134804; v20=-981.640333886776; v30 =-7090.49932929797;

%% ode and plot
% opts = odeset('RelTol',1e-3,'AbsTol',1e-5);
% [t,x] = ode45('J2fcn', [t0:tstep:  tf], [x10 v10 x20 v20 x30 v30]);
h = tstep; 
y = zeros(6,tf/h+1);
t = zeros(1,tf/h+1);
i = 1;

y(:,1) =[x10 v10 x20 v20 x30 v30]';

for j =0:h:tf-h
    
    y(:,i+1) = (J2fcn(t(i),y(:,i)))* h +  y(:,i);
    t (i+1)= t(i)+h;
    i = i+1;
   
%     k1= J2fcn(t(i), y(:,i));
%     k2= J2fcn(t(i)+h/2, y(:,i)+h*k1/2); % 3 
%     k3= J2fcn(t(i) +h/2, y (:,i)+h*k2/2); %3
%     k4= J2fcn(t(i)+h, y (:,i)+h*k3); %3
%     
%     y(:,i+1) = y(:,i)+ h/6 * (k1+2*k2 +2*k3 + k4); %6
%     t(i+1) = t(i)+ h;  %1
%     i= i+1;
   
   
end

toc

 
%J2_test_case = [[t0:tstep:tf]'; x(:,1); x(:,3);x(:,5);x(:,2);x(:,4);x(:,6)];
rr2 = sqrt(y(1,:).*y(1,:)+y(3,:).*y(3,:)+y(5,:).*y(5,:));
hold on 
plot(t, y(1,:)/1000);
plot(t, y(3,:)/1000);
plot(t, y(5,:)/1000);
plot(t, rr/1000);
hold off

rr_sgp  = sqrt(SGP_test_case(2,:).*SGP_test_case(2,:)+SGP_test_case(3,:).*SGP_test_case(3,:)+SGP_test_case(4,:).*SGP_test_case(4,:));

rr_diff_2 = (rr_sgp -rr2);
plot(rr_diff_2);
rr_diff_3 = (rr2 -rr);
plot(rr_diff_3);