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