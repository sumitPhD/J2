%% Initial condition
% time step
t0 = 0;
tstep = 0.1;
tf =240e3;  % 6*10^5 , 1 orbit - 6*10^3 

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
% x10 = 2328966.08303380; x20 =-5995216.03827729; x30 =  1719978.73535898;
% v10 =2911.10102134804; v20=-981.640333886776; v30 =-7090.49932929797;

%% ode and plot
% opts = odeset('RelTol',1e-3,'AbsTol',1e-5);
% [t,x] = ode45('J2fcn', [t0:tstep:  tf], [x10 v10 x20 v20 x30 v30]);
h = tstep; 
y1 = zeros(7,tf/h+1);
i = 1;

y1(:,1) = [0;SGP_1(2:7,1)];
tic

y1(2:7,i+1) = (J2fcn(y1(1,i),y1(2:7,i)))* h +  y1(2:7,i);
%     y1(5:7,i+1) = (J2fcn(y1(1,i),y1(5:7,i)))* h +  y1(5:7,i);
     y1(1,i+1) = y1(1,i)+ h; 
    i = i+1;
for j =h:h:tf-h
    
    y1(2:7,i+1) = (J2fcn(y1(1,i),y1(2:7,i)).*[1 1 1 2 2 2]' + [[y1(5:7,i-1)]' [0 0 0]]')* h/2 +  y1(2:7,i);
%     y1(5:7,i+1) = (J2fcn(y1(1,i),y1(5:7,i)))* h +  y1(5:7,i);
     y1(1,i+1) = y1(1,i)+ h; 
    i = i+1; 
   
end

toc
save y1.mat
rr_sgp  = sqrt(SGP_1(2,:).*SGP_1(2,:)+SGP_1(3,:).*SGP_1(3,:)+SGP_1(4,:).*SGP_1(4,:));
% rr_Y  = sqrt(y(2,:).*y(2,:)+y(3,:).*y(3,:)+y(4,:).*y(4,:));
rr_Y1  = sqrt(y1(2,:).*y1(2,:)+y1(3,:).*y1(3,:)+y1(4,:).*y1(4,:));

hold on 
plot(SGP_1(1,:),rr_sgp ,'b');
% plot(SGP_1(1,:),rr_Y ,'r');
plot(SGP_1(1,:),rr_Y1 ,'g');
hold off


%  
% %J2_test_case = [[t0:tstep:tf]'; x(:,1); x(:,3);x(:,5);x(:,2);x(:,4);x(:,6)];
% rr2 = sqrt(y1(1,:).*y1(1,:)+y1(3,:).*y1(3,:)+y1(5,:).*y1(5,:));
% hold on 
% plot(t, y1(1,:)/1000);
% plot(t, y1(3,:)/1000);
% plot(t, y1(5,:)/1000);
% plot(t, rr/1000);
% hold off
% 
% rr_sgp  = sqrt(SGP_test_case(2,:).*SGP_test_case(2,:)+SGP_test_case(3,:).*SGP_test_case(3,:)+SGP_test_case(4,:).*SGP_test_case(4,:));
% 
% rr_diff_2 = (rr_sgp -rr2);
% plot(rr_diff_2);
% rr_diff_3 = (rr2 -rr);
% plot(rr_diff_3);