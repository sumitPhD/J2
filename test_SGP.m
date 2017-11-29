%SGP_org: original sgp
%SGP_1: initial position at [1,0,0] inc = 90, all drag zero, start on pole


x = SGP_1;
r_SGP = sqrt(x(2,:).*x(2,:) + x(3,:).*x(3,:) + x(4,:).*x(4,:));

plot(x(1,:),r_SGP);