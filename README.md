# ROS Workspace setup for using Optitrack in ASTA

## Installation

First, make sure that git is installed and that you have defined your identity:

`sudo apt install git`

`git config --global user.email "you@example.com"`

`git config --global user.name "Your Name"`

Then, clone the repository and run the installation script:

`git clone https://github.com/DavidWuthier/asta_workspace_setup.git`

`cd asta_workspace_setup`

`sudo chmod +x asta_workspace_setup.sh`

`./asta_workspace_setup.sh`

## Usage

### Directly from vrpn_ws

Add this line to `~/.bashrc`:

`source ~/asta_ws/vrpn_ws/devel/setup.bash`

Restart your terminal, and run the launchfile contained in `vrpn_client_ros`:

`roslaunch vrpn_client_ros sample.launch server:=SERVER_ADDRESS`

Replace `SERVER_ADDRESS` by the IP address displayed in the "streaming pane" of Motive on the Optitrack computer.

### From your own workspace

(replace `your_ws` by the name of one of your own ROS workspace)

Add this line to `~/.bashrc`:

`source ~/path/to/your_ws/devel/setup.bash`

Restart your terminal, and go to your workspace:

`cd ~/path/to/your_ws`

Clean your build files:

`catkin clean -y`

Chain your workspace on the VRPN workspace:

`catkin config --extend ~/asta_ws/vrpn_ws/devel`

And rebuild your workspace:

`catkin build`
