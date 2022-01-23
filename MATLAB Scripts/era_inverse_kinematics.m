% Symbolic Transformation matrix 
% syms d1 
% syms a2 a3 a4 a5 a6
% syms theta1 theta2 theta3 theta4 theta5 theta6
% 
% T_01 = [[cos(theta1),0,sin(theta1),0];[sin(theta1),0,-cos(theta1),0];[0,1,0,d1];[0,0,0,1]]
% T_12 = [[cos(theta2-(pi/2)),0,sin(theta2-(pi/2)),a2*cos(theta2-(pi/2))];[sin(theta2-(pi/2)),0,-cos(theta2-(pi/2)),a2*sin(theta2-(pi/2))];[0,1,0,0];[0,0,0,1]]
% T_23 = [[cos(theta3),-sin(theta3),0,a3*cos(theta3)];[sin(theta3),cos(theta3),0,a3*sin(theta3)];[0,0,1,0];[0,0,0,1]]
% T_34 = [[cos(theta4),-sin(theta4),0,a4*cos(theta4)];[sin(theta4),cos(theta4),0,a4*sin(theta4)];[0,0,1,0];[0,0,0,1]]
% T_45 = [[cos(theta5),0,-sin(theta5),a5*cos(theta5)];[sin(theta5),0,cos(theta5),a5*sin(theta5)];[0,-1,0,0];[0,0,0,1]]
% T_5n = [[cos(theta6),-sin(theta6),0,a6*cos(theta6)];[sin(theta6),cos(theta6),0,a6*sin(theta6)];[0,0,1,0];[0,0,0,1]]
% T_0n = simplify(T_01 * T_12 * T_23 * T_34 * T_45 * T_5n);
% disp(T_0n)

% https://www.mathworks.com/help/optim/ug/optim.problemdef.equationproblem.html
d1 = 0.577;
a2 = -0.224; a3 = -1.572; a4 = -1.572; a5 = -0.224; a6 = -(0.577 + 0.260);

theta = optimvar('theta',6);
r11 = 0; r12 = 1; r13 = 0;
r21 = 0; r22 = 0; r23 = -1;
r31 = -1; r32 = 0; r33 = 0.0;
disp("Input End-Effector positions: ")
dx = 0.0; dy = 0.0; dz = 5.006;
p = [dx,dy,dz];
disp(p)

e1 = cos(theta(6))*(cos(theta(5))*(cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) - sin(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))))) + cos(theta(1))*cos(theta(2))*sin(theta(6)) == r11;
e2 = cos(theta(1))*cos(theta(2))*cos(theta(6)) - sin(theta(6))*(cos(theta(5))*(cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) - sin(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))))) == r12;
e3 = cos(theta(5))*(cos(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) - sin(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2)))) - sin(theta(5))*(cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3)))) == r13;
e4 = cos(theta(2))*sin(theta(1))*sin(theta(6)) - cos(theta(6))*(cos(theta(5))*(cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*sin(theta(1))*sin(theta(2))) + sin(theta(4))*(cos(theta(1))*cos(theta(3)) + sin(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(1))*cos(theta(3))*cos(theta(4)) - cos(theta(1))*sin(theta(3))*sin(theta(4)) + cos(theta(3))*sin(theta(1))*sin(theta(2))*sin(theta(4)) + cos(theta(4))*sin(theta(1))*sin(theta(2))*sin(theta(3)))) == r21;
e5 = sin(theta(6))*(cos(theta(5))*(cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*sin(theta(1))*sin(theta(2))) + sin(theta(4))*(cos(theta(1))*cos(theta(3)) + sin(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(1))*cos(theta(3))*cos(theta(4)) - cos(theta(1))*sin(theta(3))*sin(theta(4)) + cos(theta(3))*sin(theta(1))*sin(theta(2))*sin(theta(4)) + cos(theta(4))*sin(theta(1))*sin(theta(2))*sin(theta(3)))) + cos(theta(2))*cos(theta(6))*sin(theta(1)) == r22;
e6 = sin(theta(5))*(cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*cos(theta(2) - pi/2)*sin(theta(1))) + sin(theta(4))*(cos(theta(1))*cos(theta(3)) + cos(theta(2) - pi/2)*sin(theta(1))*sin(theta(3)))) - cos(theta(5))*(cos(theta(4))*(cos(theta(1))*cos(theta(3)) + cos(theta(2) - pi/2)*sin(theta(1))*sin(theta(3))) - sin(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*cos(theta(2) - pi/2)*sin(theta(1)))) == r23;
e7 = sin(theta(2))*sin(theta(6)) - cos(theta(6))*(cos(theta(2) + theta(3) + theta(4) + theta(5))/2 + cos(theta(3) - theta(2) + theta(4) + theta(5))/2) == r31;
e8 = cos(theta(6))*sin(theta(2)) + sin(theta(6))*(cos(theta(2) + theta(3) + theta(4) + theta(5))/2 + cos(theta(3) - theta(2) + theta(4) + theta(5))/2) == r32;
e9 = sin(theta(3) - theta(2) + theta(4) + theta(5))/2 + sin(theta(2) + theta(3) + theta(4) + theta(5))/2 == r33;

e10 = a4*cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + a4*sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) + a6*cos(theta(6))*(cos(theta(5))*(cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) - sin(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))))) + a2*cos(theta(1))*sin(theta(2)) + a5*cos(theta(5))*(cos(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + sin(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3)))) + a3*sin(theta(1))*sin(theta(3)) + a5*sin(theta(5))*(cos(theta(4))*(cos(theta(3))*sin(theta(1)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) - sin(theta(4))*(sin(theta(1))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2)))) + a3*cos(theta(1))*cos(theta(3))*sin(theta(2)) + a6*cos(theta(1))*cos(theta(2))*sin(theta(6)) == dx;
e11 = 2*sin(theta(1))*sin(theta(2)) - a4*sin(theta(4))*(cos(theta(1))*cos(theta(3)) + sin(theta(1))*sin(theta(2))*sin(theta(3))) - a3*cos(theta(1))*sin(theta(3)) - a5*cos(theta(5))*(cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*sin(theta(1))*sin(theta(2))) + sin(theta(4))*(cos(theta(1))*cos(theta(3)) + sin(theta(1))*sin(theta(2))*sin(theta(3)))) - a6*cos(theta(6))*(cos(theta(5))*(cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*sin(theta(1))*sin(theta(2))) + sin(theta(4))*(cos(theta(1))*cos(theta(3)) + sin(theta(1))*sin(theta(2))*sin(theta(3)))) + sin(theta(5))*(cos(theta(1))*cos(theta(3))*cos(theta(4)) - cos(theta(1))*sin(theta(3))*sin(theta(4)) + cos(theta(3))*sin(theta(1))*sin(theta(2))*sin(theta(4)) + cos(theta(4))*sin(theta(1))*sin(theta(2))*sin(theta(3)))) - a4*cos(theta(4))*(cos(theta(1))*sin(theta(3)) - cos(theta(3))*sin(theta(1))*sin(theta(2))) - a5*sin(theta(5))*(cos(theta(1))*cos(theta(3))*cos(theta(4)) - cos(theta(1))*sin(theta(3))*sin(theta(4)) + cos(theta(3))*sin(theta(1))*sin(theta(2))*sin(theta(4)) + cos(theta(4))*sin(theta(1))*sin(theta(2))*sin(theta(3))) + a3*cos(theta(3))*sin(theta(1))*sin(theta(2)) + a6*cos(theta(2))*sin(theta(1))*sin(theta(6)) == dy;
e12 = d1 - a2*cos(theta(2)) - a3*cos(theta(2))*cos(theta(3)) + a6*sin(theta(2))*sin(theta(6)) - a4*cos(theta(2))*cos(theta(3))*cos(theta(4)) + a4*cos(theta(2))*sin(theta(3))*sin(theta(4)) - a5*cos(theta(2))*cos(theta(3))*cos(theta(4))*cos(theta(5)) + a5*cos(theta(2))*cos(theta(3))*sin(theta(4))*sin(theta(5)) + a5*cos(theta(2))*cos(theta(4))*sin(theta(3))*sin(theta(5)) + a5*cos(theta(2))*cos(theta(5))*sin(theta(3))*sin(theta(4)) + a6*cos(theta(2))*cos(theta(3))*cos(theta(6))*sin(theta(4))*sin(theta(5)) + a6*cos(theta(2))*cos(theta(4))*cos(theta(6))*sin(theta(3))*sin(theta(5)) + a6*cos(theta(2))*cos(theta(5))*cos(theta(6))*sin(theta(3))*sin(theta(4)) - a6*cos(theta(2))*cos(theta(3))*cos(theta(4))*cos(theta(5))*cos(theta(6)) == dz;

prob = eqnproblem;
prob.Equations.eq1 = e1;
prob.Equations.eq2 = e2;
prob.Equations.eq3 = e3;
prob.Equations.eq4 = e4;
prob.Equations.eq5 = e5;
prob.Equations.eq6 = e6;
prob.Equations.eq7 = e7;
prob.Equations.eq8 = e8;
prob.Equations.eq9 = e9;
prob.Equations.eq10 = e10;
prob.Equations.eq11 = e11;
prob.Equations.eq12 = e12;

x0.theta = [0 0 0 0 0 0];
[sol,fval,exitflag] = solve(prob,x0);
disp("Resultant joint angles from IK: ")
disp(sol.theta)