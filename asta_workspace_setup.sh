#!/bin/bash

for DISTRO in noetic melodic kinetic; do
  if [ -e /opt/ros/$DISTRO ]; then
    CURRENT_DISTRO=$DISTRO
    break
  fi
done

if [ "$CURRENT_DISTRO" = "noetic" ]; then
  PYTHON_VERSION=3
fi

sudo apt install git python$PYTHON_VERSION-catkin-tools python$PYTHON_VERSION-vcstool -y

patch () {
  wget https://raw.githubusercontent.com/DavidWuthier/asta_workspace_setup/main/$1.patch
  git am -s < $1.patch
  rm $1.patch
}

if [ -n "$CURRENT_DISTRO" ]; then
  echo "setting up ASTA workspace for ROS $CURRENT_DISTRO"
  cd ~
  if [ ! -e asta_ws ]; then
    mkdir -p asta_ws/vrpn_ws/src
    cd asta_ws/vrpn_ws
    catkin init
    catkin config --extend /opt/ros/$CURRENT_DISTRO
    wget https://raw.githubusercontent.com/DavidWuthier/asta_workspace_setup/main/vrpn_ws.repos
    cd src
    git clone https://github.com/vrpn/vrpn.git
    git clone https://github.com/ros-drivers/vrpn_client_ros.git
    cd vrpn
    git submodule init
    git submodule update
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
    cd ../../vrpn_client_ros
    patch fix_cmake_module_path
    catkin build
  else
    echo "ASTA workspace already exists"
  fi
else
  echo "No ROS installation found"
fi

