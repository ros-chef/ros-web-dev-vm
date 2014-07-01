# Fully-provisioned development environment for robot-web-tools

This repository contains setup to run development for
robot-web-tools. It builds the VM that contains backing services,
development setup and environment against which you can run
integration tests.

# Quickstart

 * Install chefdk
 * Install VirtualBox and Vagrant
 * run `bundle`
 * run `berks install` to pull cookbook
 * run `kitchen converge all`

Run `kitchen login 1404` to login into the VM and run around.

# TODO:

 * add development tools to the VM
 * add catkin_ws
 * add roslibjs_integration_tests
 * rename roslibjs_integration_tests to e2e
 * sudo chown -R vagrant:vagrant ~/.
