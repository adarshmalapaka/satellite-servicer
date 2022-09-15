[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
# Modeling and Simulation of Satellite Servicing Manipulators

Final Project for the course _ENPM662: Introduction to Robot Modeling (Fall 2021)_.

The aim of this project was to simulate the European Robotic Arm (ERA) in an outer space like environment using ROS and Gazebo. The CAD model for the satellite was taken from [GrabCAD](https://grabcad.com/library/satellite-turksat-5a-1) and modified to suit our requirements. All credits go to the respective author of the satellite CAD model.

## European Robotic Arm (ERA) [^1]
<p align="center">
  <img src="https://user-images.githubusercontent.com/40534801/151640911-fae0de05-df36-4fba-a748-a92ee6fb89ac.jpg" width="300" height="300">
</p>

## Satellite + Manipulator CAD Model
<p align="center">
  <img src="https://user-images.githubusercontent.com/40534801/151640732-9a5aa22d-834c-4c3b-af70-b6195497424b.jpg" width="500" height="400">
</p>

All the SolidWorks CAD files of the Satellite Servicing assembly are in the `/CAD` directory.

## Demos
* _Servicing_ manipulator (background) cutting through the surface of the _broken_ satellite (foreground).
  <p align="center">
    <img src="https://user-images.githubusercontent.com/40534801/151640856-9f753b9e-4b2a-4a83-b979-ba0d2db79661.gif" width="600" height="400">
  </p>

* _Servicing_ manipulator (background) being controlled through teleoperation (with time-delay)
  <p align="center">
    <img src="https://user-images.githubusercontent.com/40534801/151640873-ee36fac3-b0fc-49fc-b91f-cc869f62ffa9.gif" width="600" height="400">
  </p>

<!-- ## Packages Used
- Python 3.7.11
- Matplotlib 3.5.0
- NumPy 1.21.2

  
## Code Execution

* Clone the repository
  ```
  git clone --recursive https://github.com/adarshmalapaka/autonomous-robotics.git
  ```
* Navigate to the Homework-01 folder containing the python scripts and `imudata.txt` file.

* Run the `imu_moving_average.py`file by:
  ```
  python imu_moving_average.py
  ```

* The matplotlib plots corresponding to 2-, 4-, 8-, 16-, 64- and 128-point moving averaged data are obtained.

* For the IMU animation, run the `imu_moving_average_animation.py`file by:
  ```
  python imu_moving_average_animation.py
  ```
    This displays a matplotlib animation of the IMU sensor with both the raw data and the 128-point moving averaged data. 
    Uncomment lines 141 and 145 to save the animation as MP4 videos.  -->
    
<!-- ## Contact

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com

Project Link: [https://github.com/github_username/repo_name](https://github.com/github_username/repo_name)

<p align="right">(<a href="#top">back to top</a>)</p>
 -->

[^1]: Image Courtesy: https://www.esa.int/ESA_Multimedia/Videos/2021/07/European_Robotic_Arm_ready_for_space
