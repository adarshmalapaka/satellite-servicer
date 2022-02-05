## Files
**Package Name:** _satellite_servicer_
* **Common Launch file:** _servicing_arm.launch_
* **Teleop Launch:** _servicing_teleop.launch_
* **Teleop Script:** _sat_serv_teleop.py_
* **Cutting Launch:** _servicing_cutting.launch_
* **Cutting Script:** _sat_serv_cutting.py_
* **Move to Points Launch:** _servicing_move.launch_
* **Move to Points Script:** _move_to_points_pub.py_

Add the given package folder (satellite_servicer) in the _src_ folder of your ROS workspace.

## To run the teleop-demo:

1. Open a terminal and run the following: 
   ```
   cd catkin_ws
   catkin_make
   ```

2. Run the following to launch the satellite system in the Gazebo world:
   ```
   `roslaunch satellite_servicer servicing_arm.launch`
   ```
   This opens the world in 'paused' state and -9.8 gravity by default. 

3. In another terminal, run:  
   ```
   roslaunch satellite_servicer servicing_teleop.launch
   ```
   As the scripts are running, immediately head to Gazebo and click the Play button on the bottom left corner. The gravity value is set to -2.5.

4. Open the `joint_state_publisher` GUI and change the slider values to publish the corresponding joint angle value to the robot in both Gazebo & RViz.

5. Note: This demo includes time-delay and hence the robot shall take some time to reflect the newly given input, please be patient.  


## To run the cutting demo:

1. Open a terminal and run the following: 
   ```
   cd catkin_ws
   catkin_make
   ```

2. Run the following to launch the satellite system in the Gazebo world:
   ```
   `roslaunch satellite_servicer servicing_arm.launch`
   ```
   This opens the world in 'paused' state and -9.8 gravity by default. 

3. In another terminal, run the following to bring up the ROS node that performs inverse velocity kinematics to generate cutting trajectory of the robot arm. It also sets the gravity value to -2.5:  
   ```
   rosrun satellite_servicer sat_serv_teleop.py
   ```

4. Open RViz by: 
   ```
   rosrun rviz rviz
   ```
   Add two Camera visualizations with the ROS topics - `/sat_serv/blade_camera/image_raw/image_topics` and `/sat_serv/rear_camera/image_raw/image_topics` to display the 2 camera feed views mounted on the manipulator arm.



