#!/usr/bin/env python
import rospy
from std_msgs.msg import Float64
from sensor_msgs.msg import JointState
import gazebo_msgs.msg 
import geometry_msgs.msg
from gazebo_msgs.srv import SetPhysicsProperties
from sympy import Matrix, symbols, cos, sin, simplify, pi, pprint, diff


# Source: https://answers.gazebosim.org//question/17157/how-to-change-gravity-in-python-codequestions-on-reseting-the-model/?answer=17233#post-id-17233
print("Setting low gravity value to simulate space")
set_gravity = rospy.ServiceProxy('/gazebo/set_physics_properties', SetPhysicsProperties)
time_step = Float64(0.001)
max_update_rate = Float64(1000.0)
gravity = geometry_msgs.msg.Vector3()
gravity.x = 0.0
gravity.y = 0.0
gravity.z = -2.5
ode_config = gazebo_msgs.msg.ODEPhysics()
ode_config.auto_disable_bodies = False
ode_config.sor_pgs_precon_iters = 0
ode_config.sor_pgs_iters = 50
ode_config.sor_pgs_w = 1.3
ode_config.sor_pgs_rms_error_tol = 0.0
ode_config.contact_surface_layer = 0.001
ode_config.contact_max_correcting_vel = 0.0
ode_config.cfm = 0.0
ode_config.erp = 0.2
ode_config.max_contacts = 20
set_gravity(time_step.data, max_update_rate.data, gravity, ode_config)


tool_length = 0.26    # (m)
N = 30                # no. of data points
delta_time = 30/N     # time between successive data points

d1 = 0.577
a2 = -0.224
a3 = -1.572
a4 = -1.572
a5 = -0.224
a6 = -0.577 - tool_length

# Defining the symbolic joint angle symbolic variables 
q1, q2, q3, q4, q5, q6 = symbols('q1, q2, q3, q4, q5, q6')

# Function to obtain Transformation matrix between consecutive links 
def get_tf(q,d,a,alpha):
    T = Matrix([[cos(q),-sin(q)*cos(alpha),sin(q)*sin(alpha),a*cos(q)], [sin(q),cos(q)*cos(alpha),-cos(q)*sin(alpha),a*sin(q)], [0,sin(alpha),cos(alpha),d], [0,0,0,1]])    
    return T

print("\n**** Generating the necessary Transformation matrices of all links, please wait. ****")

# get_tf(q,d,a,alpha)
T_01 = get_tf(q1,d1,0,pi/2) # A_1
T_12 = get_tf(q2-(pi/2),0,a2,pi/2)
T_23 = get_tf(q3,0,a3,0)
T_34 = get_tf(q4,0,a4,0)
T_45 = get_tf(q5,0,a5,-pi/2)
T_5n = get_tf(q6,0,a6,0)

T_02 = T_01 * T_12 # A_2
T_03 = T_02 * T_23 # A_3
T_04 = T_03 * T_34 # A_4
T_05 = T_04 * T_45 # A_5
T_0n = T_05 * T_5n # A_n

print("\n**** Generating the necessary parametric Jacobian matrix, please wait. ****")
print("\n**** It may take upto 3 minutes to generate the Jacobian matrix, please wait. ****")
Z_0 = Matrix([0, 0, 1])
Z_1 = simplify(T_01[0:3,2])
Z_2 = simplify(T_02[0:3,2])
Z_3 = simplify(T_03[0:3,2])
Z_4 = simplify(T_04[0:3,2])
Z_5 = simplify(T_05[0:3,2])
Z_n = simplify(T_0n[0:3,2])

x_p = T_0n[0:3,3]

h_1 = diff(x_p,q1)
h_2 = diff(x_p,q2)
h_3 = diff(x_p,q3)
h_4 = diff(x_p,q4)
h_5 = diff(x_p,q5)
h_6 = diff(x_p,q6)
J_v1 = simplify(h_1)
J_v2 = simplify(h_2)
J_v3 = simplify(h_3)
J_v4 = simplify(h_4)
J_v5 = simplify(h_5)
J_v6 = simplify(h_6)

J_v = Matrix().col_insert(0,J_v1).col_insert(1,J_v2).col_insert(2,J_v3).col_insert(3,J_v4).col_insert(4,J_v5).col_insert(5,J_v6)
J_w = Matrix().col_insert(0,Z_0).col_insert(1,Z_1).col_insert(2,Z_2).col_insert(3,Z_3).col_insert(4,Z_4).col_insert(5,Z_5) 
J = Matrix().row_insert(0,J_v).row_insert(3,J_w)

print("\n***************************************************************************")
print("                           Jacobian Matrix (J):                              ")
print("****************************************************************************\n")
print(J)

# Function to compute the inverse kinematics q_dot values from end-effector velocities.
def inverse_velocity_kinematics(X_dot, q_joint):
    J_inv = J.evalf(3,subs={q1: q_joint[0],q2: q_joint[1], q3: q_joint[2], q4: q_joint[3], q5: q_joint[4], q6: q_joint[5]}).inv()
    q_dot = J_inv * X_dot # Generalized joint velocity components from Jacobian inverse
    return q_dot


# Function to compute new value of joint angle based on q_dot and previous angle
def update_joint_angle(q, q_dot):
    q = q + q_dot*delta_time
    return q


# Function to compute forward kinematics (position) to obtain the end-effector (Pen) (x,y,z) co-ords wrt base frame
def forward_position_kinematics(q):
    T = T_0n.evalf(subs={q1: q[0],q2: q[1], q3: q[2], q4: q[3], q5: q[4], q6: q[5]})
    return (T[0,3].round(4),T[1,3].round(4),T[2,3].round(4))


def cutting_traj():

    q_joint = Matrix([0.0, 0.0, -1.0, float(pi/2), 0.5, 0.0])

    rospy.loginfo("\n******* Moving the robot arm! *******")

    for i in range(0,N):
        X_dot = Matrix([0.0, 0.0, -0.1, 0.0, 0.0, 0.0])
        q_dot_joint = inverse_velocity_kinematics(X_dot, q_joint)

        pub_joint1_pos.publish(q_joint[0])
        pub_joint2_pos.publish(q_joint[1])
        pub_joint3_pos.publish(q_joint[2])
        pub_joint4_pos.publish(q_joint[3])
        pub_joint5_pos.publish(q_joint[4])
        pub_joint6_pos.publish(q_joint[5])

        q_joint = update_joint_angle(q_joint, q_dot_joint)

    rospy.loginfo("\n******* Finished cutting! *******")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

if __name__ == '__main__':
    try:

        # inititalizing node
        rospy.init_node('sat_serv_cutting_node', anonymous=False)

        # robot arm joint position publishers
        # pub_joint1_pos = rospy.Publisher('/satellite_servicer/joint1_pos_control/command/delayed', Float64, queue_size=10) 
        # pub_joint2_pos = rospy.Publisher('/satellite_servicer/joint2_pos_control/command/delayed', Float64, queue_size=10)
        # pub_joint3_pos = rospy.Publisher('/satellite_servicer/joint3_pos_control/command/delayed', Float64, queue_size=10)
        # pub_joint4_pos = rospy.Publisher('/satellite_servicer/joint4_pos_control/command/delayed', Float64, queue_size=10)
        # pub_joint5_pos = rospy.Publisher('/satellite_servicer/joint5_pos_control/command/delayed', Float64, queue_size=10)
        # pub_joint6_pos = rospy.Publisher('/satellite_servicer/joint6_pos_control/command/delayed', Float64, queue_size=10)
        pub_joint1_pos = rospy.Publisher('/satellite_servicer/joint1_pos_control/command', Float64, queue_size=10) 
        pub_joint2_pos = rospy.Publisher('/satellite_servicer/joint2_pos_control/command', Float64, queue_size=10)
        pub_joint3_pos = rospy.Publisher('/satellite_servicer/joint3_pos_control/command', Float64, queue_size=10)
        pub_joint4_pos = rospy.Publisher('/satellite_servicer/joint4_pos_control/command', Float64, queue_size=10)
        pub_joint5_pos = rospy.Publisher('/satellite_servicer/joint5_pos_control/command', Float64, queue_size=10)
        pub_joint6_pos = rospy.Publisher('/satellite_servicer/joint6_pos_control/command', Float64, queue_size=10)

        cutting_traj()

    except rospy.ROSInterruptException: 
        pass