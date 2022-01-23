d1 = 0.577;
a2 = -0.224; a3 = -1.572; a4 = -1.572; a5 = -0.224; a6 = -(0.577 + 0.260);

disp("Case 1: All Joint Angles (rad) are 0 ")
theta1 = 0 * pi/180;
theta2 = 0 * pi/180;
theta3 = 0 * pi/180;
theta4 = 0 * pi/180;
theta5 = 0 * pi/180;
theta6 = 0 * pi/180;
theta = [theta1, theta2, theta3, theta4, theta5, theta6];
disp(theta)
% T_01 = t_matrix(a,d,theta,alpha)
T_01 = [[cos(theta1),0,sin(theta1),0];[sin(theta1),0,-cos(theta1),0];[0,1,0,d1];[0,0,0,1]];

T_12 = [[cos(theta2-(pi/2)),0,sin(theta2-(pi/2)),a2*cos(theta2-(pi/2))];[sin(theta2-(pi/2)),0,-cos(theta2-(pi/2)),a2*sin(theta2-(pi/2))];[0,1,0,0];[0,0,0,1]];

T_23 = [[cos(theta3),-sin(theta3),0,a3*cos(theta3)];[sin(theta3),cos(theta3),0,a3*sin(theta3)];[0,0,1,0];[0,0,0,1]];

T_34 = [[cos(theta4),-sin(theta4),0,a4*cos(theta4)];[sin(theta4),cos(theta4),0,a4*sin(theta4)];[0,0,1,0];[0,0,0,1]];

T_45 = [[cos(theta5),0,-sin(theta5),a5*cos(theta5)];[sin(theta5),0,cos(theta5),a5*sin(theta5)];[0,-1,0,0];[0,0,0,1]];

T_5n = [[cos(theta6),-sin(theta6),0,a6*cos(theta6)];[sin(theta6),cos(theta6),0,a6*sin(theta6)];[0,0,1,0];[0,0,0,1]];

T_0n = T_01 * T_12 * T_23 * T_34 * T_45 * T_5n;

disp("Resultant transformation matrix between cutter tool blade and base frame: ")
disp(T_0n)

disp("Case 2: q2 = 90, other angles = 0")
theta1 = 0 * pi/180;
theta2 = 90 * pi/180;
theta3 = 0 * pi/180;
theta4 = 0 * pi/180;
theta5 = 0 * pi/180;
theta6 = 0 * pi/180;
theta = [theta1, theta2, theta3, theta4, theta5, theta6];
disp(theta)
% T_01 = t_matrix(a,d,theta,alpha)
T_01 = [[cos(theta1),0,sin(theta1),0];[sin(theta1),0,-cos(theta1),0];[0,1,0,d1];[0,0,0,1]];

T_12 = [[cos(theta2-(pi/2)),0,sin(theta2-(pi/2)),a2*cos(theta2-(pi/2))];[sin(theta2-(pi/2)),0,-cos(theta2-(pi/2)),a2*sin(theta2-(pi/2))];[0,1,0,0];[0,0,0,1]];

T_23 = [[cos(theta3),-sin(theta3),0,a3*cos(theta3)];[sin(theta3),cos(theta3),0,a3*sin(theta3)];[0,0,1,0];[0,0,0,1]];

T_34 = [[cos(theta4),-sin(theta4),0,a4*cos(theta4)];[sin(theta4),cos(theta4),0,a4*sin(theta4)];[0,0,1,0];[0,0,0,1]];

T_45 = [[cos(theta5),0,-sin(theta5),a5*cos(theta5)];[sin(theta5),0,cos(theta5),a5*sin(theta5)];[0,-1,0,0];[0,0,0,1]];

T_5n = [[cos(theta6),-sin(theta6),0,a6*cos(theta6)];[sin(theta6),cos(theta6),0,a6*sin(theta6)];[0,0,1,0];[0,0,0,1]];

T_0n = T_01 * T_12 * T_23 * T_34 * T_45 * T_5n;

disp("Resultant transformation matrix between cutter tool blade and base frame: ")
disp(T_0n)

disp("Case 3: q1, q4 = 90, other angles = 0")
theta1 = 90 * pi/180;
theta2 = 0 * pi/180;
theta3 = 0 * pi/180;
theta4 = 90 * pi/180;
theta5 = 0 * pi/180;
theta6 = 0 * pi/180;
theta = [theta1, theta2, theta3, theta4, theta5, theta6];
disp(theta)
% T_01 = t_matrix(a,d,theta,alpha)
T_01 = [[cos(theta1),0,sin(theta1),0];[sin(theta1),0,-cos(theta1),0];[0,1,0,d1];[0,0,0,1]];

T_12 = [[cos(theta2-(pi/2)),0,sin(theta2-(pi/2)),a2*cos(theta2-(pi/2))];[sin(theta2-(pi/2)),0,-cos(theta2-(pi/2)),a2*sin(theta2-(pi/2))];[0,1,0,0];[0,0,0,1]];

T_23 = [[cos(theta3),-sin(theta3),0,a3*cos(theta3)];[sin(theta3),cos(theta3),0,a3*sin(theta3)];[0,0,1,0];[0,0,0,1]];

T_34 = [[cos(theta4),-sin(theta4),0,a4*cos(theta4)];[sin(theta4),cos(theta4),0,a4*sin(theta4)];[0,0,1,0];[0,0,0,1]];

T_45 = [[cos(theta5),0,-sin(theta5),a5*cos(theta5)];[sin(theta5),0,cos(theta5),a5*sin(theta5)];[0,-1,0,0];[0,0,0,1]];

T_5n = [[cos(theta6),-sin(theta6),0,a6*cos(theta6)];[sin(theta6),cos(theta6),0,a6*sin(theta6)];[0,0,1,0];[0,0,0,1]];

T_0n = T_01 * T_12 * T_23 * T_34 * T_45 * T_5n;

disp("Resultant transformation matrix between cutter tool blade and base frame: ")
disp(T_0n)
