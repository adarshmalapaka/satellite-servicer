#!/usr/bin/env python
import rospy
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64
import gazebo_msgs.msg 
import geometry_msgs.msg
from gazebo_msgs.srv import SetPhysicsProperties

def joint_states_cb(msg):
    pub_joint1_pos.publish(msg.position[0])
    pub_joint2_pos.publish(msg.position[1])
    pub_joint3_pos.publish(msg.position[2])
    pub_joint4_pos.publish(msg.position[3])
    pub_joint5_pos.publish(msg.position[4])
    pub_joint6_pos.publish(msg.position[5])

    # print(msg.position[0],msg.position[1],msg.position[2],msg.position[3],msg.position[4],msg.position[5])
        
def set_space_gravity():
    
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

    rospy.init_node("sat_serv_teleop")
    
    pub_joint1_pos = rospy.Publisher("/satellite_servicer/joint1_pos_control/command/delayed", Float64, queue_size=1)
    pub_joint2_pos = rospy.Publisher("/satellite_servicer/joint2_pos_control/command/delayed", Float64, queue_size=1)
    pub_joint3_pos = rospy.Publisher("/satellite_servicer/joint3_pos_control/command/delayed", Float64, queue_size=1)
    pub_joint4_pos = rospy.Publisher("/satellite_servicer/joint4_pos_control/command/delayed", Float64, queue_size=1)
    pub_joint5_pos = rospy.Publisher("/satellite_servicer/joint5_pos_control/command/delayed", Float64, queue_size=1)
    pub_joint6_pos = rospy.Publisher("/satellite_servicer/joint6_pos_control/command/delayed", Float64, queue_size=1)

    rospy.Subscriber("/joint_states", JointState, joint_states_cb, queue_size=1)

    set_space_gravity()


    rospy.spin()