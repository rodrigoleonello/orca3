Robot description files for [Orca3](https://github.com/clydemcqueen/orca3).

Colcon will run [Xacro](https://index.ros.org/r/xacro/github-ros-xacro/) to create `orca.urdf` from `orca.urdf.xacro`.
To convert manually:

~~~
# Install Xacro
sudo apt install ros-$ROS_DISTRO-xacro

# Source setup.bash
export ROS_DISTRO=<the latest distro>
source /opt/ros/$ROS_DISTRO/setup.bash

# Run in orca_description/urdf directory
cd src/orca3/orca_description/urdf
python3 /opt/ros/$ROS_DISTRO/bin/xacro orca.urdf.xacro > orca.urdf
~~~