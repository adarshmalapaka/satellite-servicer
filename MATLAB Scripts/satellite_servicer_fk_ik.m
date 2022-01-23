%satellite_servicer_fk_ik.m
% FK and IK validation of ERA Satellite Servicing robot 

% Link offsets (d) [m]
d1 = 0.577;  

% Link lengths (a) [m]
a2 = -0.224;  a3 = -1.572;  a4 = -1.572; a5 = -0.224; a6 = -0.577 - 0.260; 

% D-H Table  
% L(i)= Link ( [theta    d     a     alpha   ])
  L(1)= Link ( [0,       d1,   0,    pi/2    ]);
  L(2)= Link ( [-(pi/2), 0,    a2,   pi/2    ]);  
  L(3)= Link ( [0,       0,    a3,   0       ]);
  L(4)= Link ( [0,       0,    a4,   0       ]);
  L(5)= Link ( [0,       0,    a5,   -(pi/2) ]);
  L(6)= Link ( [0,       0,    a6,   0       ]);

  robot = SerialLink (L);
  robot.name = 'Satellite Servicer';
  
  deg2rad = pi/180;
  
% Position 1
disp("************************************")
disp("Case 1: All Joint angles = 0");
q1 = 0 * deg2rad;
q2 = 0 * deg2rad - (pi/2);
q3 = 0 * deg2rad;
q4 = 0 * deg2rad;
q5 = 0 * deg2rad;
q6 = 0 * deg2rad; % radians
robot.plot ([q1, q2, q3, q4, q5, q6])
hold on
pause(5.5)
% disp("Transformation Matrix");
T = robot.fkine([q1, q2, q3, q4, q5, q6]);
inv_T = robot.ikine(T);
disp("Position #1 from Forward Kinematics");
x_pos = T.t(1,1)
y_pos = T.t(2,1)
z_pos = T.t(3,1)
disp("Joint angles from Inverse Forward Kinematics");
inv_T(2) = inv_T(2)+(pi/2);
disp(inv_T)

% Position 2
disp("************************************")
disp("Case 2: q2 = 90, other angles = 0");
q1 = 0 * deg2rad;
q2 = 90 * deg2rad - (pi/2);
q3 = 0 * deg2rad;
q4 = 0 * deg2rad;
q5 = 0 * deg2rad;
q6 = 0 * deg2rad; % radians
robot.plot ( [ q1, q2, q3, q4, q5, q6 ])
hold on
pause(0.5)
% disp("Transformation Matrix");
T = robot.fkine([ q1, q2, q3, q4, q5, q6 ])
inv_T = robot.ikine(T);
disp("Position #2 from Forward Kinematics");
x_pos = T.t(1,1)
y_pos = T.t(2,1)
z_pos = T.t(3,1)
disp("Joint angles from Inverse Forward Kinematics");
inv_T(2) = inv_T(2)+(pi/2);
disp(inv_T)

% Position 3
disp("************************************")
disp("Case 3: q1, q4 = 90, other angles = 0");
q1 = 90 * deg2rad;
q2 = 0 * deg2rad - (pi/2);
q3 = 0 * deg2rad;
q4 = 90 * deg2rad;
q5 = 0 * deg2rad;
q6 = 0 * deg2rad; % radians
robot.plot ( [ q1, q2, q3, q4, q5, q6 ]);
hold on
pause(0.5)
% disp("Transformation Matrix");
T = robot.fkine([ q1, q2, q3, q4, q5, q6 ])
inv_T = robot.ikine(T);
disp("Position from Forward Kinematics");
x_pos = T.t(1,1)
y_pos = T.t(2,1)
z_pos = T.t(3,1)
disp("Joint angles from Inverse Forward Kinematics");
inv_T(2) = inv_T(2)+(pi/2);
disp(inv_T)