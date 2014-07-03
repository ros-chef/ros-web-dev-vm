# Fully-provisioned development environment for robot-web-tools

This repository contains setup to run development for
robot-web-tools. It builds the VM that contains backing services,
development setup and environment against which you can run
integration tests.

You can also just download a pre-built VM and run with it.

# Super-Quickstart
 * Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads)
 * cd prebuilt
 * vagrant up
 * go to the demo page: http://localhost:8081/examples/demo.html

# Quickstart

 * Install [chefdk](http://www.getchef.com/downloads/chef-dk/mac/)
 * Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads)
 * run `bundle`
 * run `berks install` to pull cookbook
 * run `kitchen converge 1404`
 * run `kitchen login 1404` then `sudo dpkg --configure -a` then `C^-d` (exit)
    - It seems that apt-get install ros-..-desktop-full takes too long (TODO #1)
 * run `kitchen converge 1404`

Run `kitchen login 1404` to login into the VM and run around.


# TODOs:

 * Make consistent provisioning
 * add development tools to the VM (emacs, vim, etc??)
 * test sharing directories between the local and the VM
 * tweak the VM memory settings
 * add nginx/tengine web server to serve requests and proxy to apps
 * add catkin_ws
 * add roslibjs_integration_tests
 * rename roslibjs_integration_tests to e2e

# Packaging

You'd need to get an S3 IAM user that has access to ros-chef bucket to upload the box.

    kitchen destroy 1404
    time kitchen converge 1404

    export VERSION=0.1.0
    export BOX="ros-web-dev-vm-ubuntu-14.04-${VERSION}.box"
    cd .kitchen/kitchen-vagrant/default-ubuntu-1404
    time vagrant package --output /Volumes/ros/ros-boxes/$BOX
    s3cmd --acl-public put /Volumes/ros/ros-boxes/$BOX s3://ros-chef/vagrant/boxes/

Edit prebuilt/Vagrantfile to point to the new box version URL

# What's going on?
 * ROS (indigo, desktop-full) is installed on the VM.
 * roslibjs is cloned; all dependencies are installed & and it's [built](https://github.com/ros-chef/ros-web-dev/blob/master/recipes/rwt_dev_setup.rb#L39)
 * angular-ros is cloned; all dependencies are installed

 * roscore is launced (see ~/.ros/sv)
 * rosbridge is [launced](https://github.com/ros-chef/ros-web-dev/blob/master/recipes/default.rb#L51) (see ~/.ros/sv)
 * fibbonacci server is [launced](https://github.com/ros-chef/ros-web-dev/blob/master/recipes/default.rb#L57) as a daemon (see ~/.ros/sv)

 * python simple server is
   [launched](https://github.com/ros-chef/ros-web-dev/blob/master/recipes/angular_ros.rb#L20)
   in ~/rwt/angular-ros on port 8081

 * Port 9090 and 8081 are forwarded from the local into the VM, so that you can server static

# Why?

 * A simple, reproducible environment will help people with web-dev skills get started and contribute w/o major manual setup
 * Setting up ROS natively on OsX isn't terribly easy. A VM is a great alternative.
