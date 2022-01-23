#!/usr/bin/env python
import rospy
from std_msgs.msg import Float64
from sensor_msgs.msg import JointState
import gazebo_msgs.msg 
import geometry_msgs.msg
from gazebo_msgs.srv import SetPhysicsProperties

    
def move_to_points():
    q1_d = 1.5708
    q2_d = -0.1002
    q3_d = -0.2343
    q4_d = 0.8939
    q5_d = 0.3732
    q6_d = 0.0

    while (not rospy.is_shutdown()):

        rospy.loginfo("Going to goal 1")
        pub_joint1_pos.publish(q1_d)
        pub_joint2_pos.publish(q2_d)
        pub_joint3_pos.publish(q3_d)
        pub_joint4_pos.publish(q4_d)
        pub_joint5_pos.publish(q5_d)
        pub_joint6_pos.publish(q6_d)

        rospy.sleep(0.5)

        rospy.loginfo("Going to goal 2")
        pub_joint1_pos.publish(q1_d)
        pub_joint2_pos.publish(q2_d)
        pub_joint3_pos.publish(0.5)
        pub_joint4_pos.publish(q4_d)
        pub_joint5_pos.publish(q5_d)
        pub_joint6_pos.publish(q6_d)

        rospy.sleep(0.5)

        rospy.loginfo("Going to goal 3")
        pub_joint1_pos.publish(q1_d)
        pub_joint2_pos.publish(q2_d)
        pub_joint3_pos.publish(q3_d)
        pub_joint4_pos.publish(q4_d)
        pub_joint5_pos.publish(q5_d)
        pub_joint6_pos.publish(q6_d)

        rospy.sleep(0.5)
        
        rospy.loginfo("Going to goal 4")
        pub_joint1_pos.publish(q1_d)
        pub_joint2_pos.publish(-0.5)
        pub_joint3_pos.publish(q3_d)
        pub_joint4_pos.publish(q4_d)
        pub_joint5_pos.publish(q5_d)
        pub_joint6_pos.publish(q6_d)
            
        rospy.sleep(0.5)

        rospy.loginfo("Going to goal 5")
        pub_joint1_pos.publish(q1_d)
        pub_joint2_pos.publish(0.0)
        pub_joint3_pos.publish(q3_d)
        pub_joint4_pos.publish(q4_d)
        pub_joint5_pos.publish(q5_d)
        pub_joint6_pos.publish(q6_d)
        
        rospy.loginfo("Goals reached!")

        rospy.sleep(0.5)

        rospy.loginfo("Going to home position")
        pub_joint1_pos.publish(0.0)
        pub_joint2_pos.publish(0.0)
        pub_joint3_pos.publish(0.0)
        pub_joint4_pos.publish(0.0)
        pub_joint5_pos.publish(0.0)
        pub_joint6_pos.publish(0.0)

        rospy.sleep(2.0)

def set_space_gravity():
    # Source: https://answers.gazebosim.org//question/17157/how-to-change-gravity-in-python-codequestions-on-reseting-the-model/?answer=17233#post-id-17233
    rospy.loginfo("Setting low gravity value to simulate space")
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

if __name__ == '__main__':
    try:

        # inititalizing node
        rospy.init_node('move_to_points_pub', anonymous=False)
        set_space_gravity()
        # robot arm joint position publishers
        pub_joint1_pos = rospy.Publisher('/satellite_servicer/joint1_pos_control/command/delayed', Float64, queue_size=10) 
        pub_joint2_pos = rospy.Publisher('/satellite_servicer/joint2_pos_control/command/delayed', Float64, queue_size=10)
        pub_joint3_pos = rospy.Publisher('/satellite_servicer/joint3_pos_control/command/delayed', Float64, queue_size=10)
        pub_joint4_pos = rospy.Publisher('/satellite_servicer/joint4_pos_control/command/delayed', Float64, queue_size=10)
        pub_joint5_pos = rospy.Publisher('/satellite_servicer/joint5_pos_control/command/delayed', Float64, queue_size=10)
        pub_joint6_pos = rospy.Publisher('/satellite_servicer/joint6_pos_control/command/delayed', Float64, queue_size=10)

        while(pub_joint2_pos.get_num_connections() <= 0):
            pass

        
        # sub_joint_pos = rospy.Subscriber("/satellite_servicer/joint_states", JointState, joint_states_cb)

        # while(sub_joint_pos.get_num_connections() <= 0):
        #     pass
            
        # q1_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[0]
        # q2_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[1]
        # q3_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[2]
        # q4_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[3]
        # q5_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[4]
        # q6_m = rospy.wait_for_message("/satellite_servicer/joint_states", JointState).position[5]
        # print(q1_m,q2_m)

        move_to_points()

    except rospy.ROSInterruptException: 
        pass