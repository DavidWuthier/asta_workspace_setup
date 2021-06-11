# ROS Workspace setup for using Optitrack in ASTA

## Installation

First, make sure that git is installed and that you have defined your identity:

`git config --global user.email "you@example.com"`

`git config --global user.name "Your Name"`

Then, clone the repository and run the installation script:

`git clone https://github.com/DavidWuthier/asta_workspace_setup.git`

`cd asta_workspace_setup`

`sudo chmod +x asta_workspace_setup.sh`

`./asta_workspace_setup.sh`

## Usage

Run the launchfile contained in `vrpn_client_ros`:

`roslaunch vrpn_client_ros sample.launch server:=SERVER_ADDRESS`

Replace `SERVER_ADDRESS` by the IP address displayed in the "streaming pane" of Motive on the Optitrack computer.
