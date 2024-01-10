#!/bin/bash

# This is a sample pre_build.sh script

# Update package list and install Apache HTTP Server
sudo apt-get update
sudo apt-get install -y apache2

# Start the Apache service
sudo service apache2 start

# Add any additional pre-build commands as needed
