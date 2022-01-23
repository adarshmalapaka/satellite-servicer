% ERA D-H parameters
d1 = 0.577;
a2 = -0.224; a3 = -1.572; a4 = -1.572; a5 = -0.224; a6 = -(0.577 + 0.260);

% Angles from -90 to 90, 10 evenly spaced data points  
q1 = linspace(-90,90,10)*pi/180;
q2 = linspace(-90,90,10)*pi/180;
q3 = linspace(-90,90,10)*pi/180;
q4 = linspace(-90,90,10)*pi/180;
q5 = linspace(-90,90,10)*pi/180;
q6 = linspace(-90,90,1  0)*pi/180;

[Q1,Q2,Q3,Q4,Q5,Q6]=ndgrid(q1,q2,q3,q4,q5,q6);  %Grid of angles between -90 to 90 degrees

%Using the inverse kinematic equations of the ERA robot arm
x_ee = round(a4.*cos(Q4).*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2)) + a4.*sin(Q4).*(cos(Q3).*sin(Q1) - cos(Q1).*sin(Q2).*sin(Q3)) + a6.*cos(Q6).*(cos(Q5).*(cos(Q4).*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2)) + sin(Q4).*(cos(Q3).*sin(Q1) - cos(Q1).*sin(Q2).*sin(Q3))) + sin(Q5).*(cos(Q4).*(cos(Q3).*sin(Q1) - cos(Q1).*sin(Q2).*sin(Q3)) - sin(Q4).*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2)))) + a2.*cos(Q1).*sin(Q2) + a5.*cos(Q5).*(cos(Q4).*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2)) + sin(Q4).*(cos(Q3).*sin(Q1) - cos(Q1).*sin(Q2).*sin(Q3))) + a3.*sin(Q1).*sin(Q3) + a5.*sin(Q5).*(cos(Q4).*(cos(Q3).*sin(Q1) - cos(Q1).*sin(Q2).*sin(Q3)) - sin(Q4).*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2))) + a3.*cos(Q1).*cos(Q3).*sin(Q2) + a6.*cos(Q1).*cos(Q2).*sin(Q6));
y_ee = round(a2.*sin(Q1).*sin(theta2) - a4.*sin(Q4).*(cos(Q1).*cos(Q3) + sin(Q1).*sin(theta2).*sin(Q3)) - a3.*cos(Q1).*sin(Q3) - a5.*cos(Q5).*(cos(Q4).*(cos(Q1).*sin(Q3) - cos(Q3).*sin(Q1).*sin(theta2)) + sin(Q4).*(cos(Q1).*cos(Q3) + sin(Q1).*sin(theta2).*sin(Q3))) - a6.*cos(Q6).*(cos(Q5).*(cos(Q4).*(cos(Q1).*sin(Q3) - cos(Q3).*sin(Q1).*sin(theta2)) + sin(Q4).*(cos(Q1).*cos(Q3) + sin(Q1).*sin(theta2).*sin(Q3))) + sin(Q5).*(cos(Q1).*cos(Q3).*cos(Q4) - cos(Q1).*sin(Q3).*sin(Q4) + cos(Q3).*sin(Q1).*sin(theta2).*sin(Q4) + cos(Q4).*sin(Q1).*sin(theta2).*sin(Q3))) - a4.*cos(Q4).*(cos(Q1).*sin(Q3) - cos(Q3).*sin(Q1).*sin(theta2)) - a5.*sin(Q5).*(cos(Q1).*cos(Q3).*cos(Q4) - cos(Q1).*sin(Q3).*sin(Q4) + cos(Q3).*sin(Q1).*sin(theta2).*sin(Q4) + cos(Q4).*sin(Q1).*sin(theta2).*sin(Q3)) + a3.*cos(Q3).*sin(Q1).*sin(theta2) + a6.*cos(theta2).*sin(Q1).*sin(Q6));
z_ee = round(d1 - a2.*cos(theta2) - a3.*cos(theta2).*cos(Q3) + a6.*sin(theta2).*sin(Q6) - a4.*cos(theta2).*cos(Q3).*cos(Q4) + a4.*cos(theta2).*sin(Q3).*sin(Q4) - a5.*cos(theta2).*cos(Q3).*cos(Q4).*cos(Q5) + a5.*cos(theta2).*cos(Q3).*sin(Q4).*sin(Q5) + a5.*cos(theta2).*cos(Q4).*sin(Q3).*sin(Q5) + a5.*cos(theta2).*cos(Q5).*sin(Q3).*sin(Q4) + a6.*cos(theta2).*cos(Q3).*cos(Q6).*sin(Q4).*sin(Q5) + a6.*cos(theta2).*cos(Q4).*cos(Q6).*sin(Q3).*sin(Q5) + a6.*cos(theta2).*cos(Q5).*cos(Q6).*sin(Q3).*sin(Q4) - a6.*cos(theta2).*cos(Q3).*cos(Q4).*cos(Q5).*cos(Q6));

plot3(x_ee(:),y_ee(:),z_ee(:),'.') 

xlabel('X')
ylabel('Y')
zlabel('Z')