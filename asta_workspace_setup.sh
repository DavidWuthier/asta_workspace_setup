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

sudo apt install git python$PYTHON_VERSION-catkin-tools python$PYTHON_VERSION-vcstool

patch () {
  wget https://raw.githubusercontent.com/DavidWuthier/asta_workspace_setup/main/$1.patch
  git am -s < $1.patch
  rm $1.patch
}

if [ -n "$CURRENT_DISTRO" ]; then
  echo "setting up workspace for ROS $CURRENT_DISTRO"
  cd ~
  if [ ! -e asta_ws ]; then
    mkdir -p asta_ws/src
    cd asta_ws
    catkin init
    catkin config --extend /opt/ros/$CURRENT_DISTRO
    wget https://raw.githubusercontent.com/DavidWuthier/asta_workspace_setup/main/asta_ws.repos
    vcs import < asta_ws.repos
    cd src/vrpn
    git submodule init
    git submodule update
    patch catkinize_package
    cd ../vrpn_client_ros
    patch fix_cmake_module_path
    catkin build
  else
    echo "ASTA workspace already exists"
  fi
else
  echo "No ROS installation found"
fi

