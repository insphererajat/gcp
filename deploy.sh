#!/bin/bash

# This is a sample deploy.sh script

# Install PHP 8.0 and related packages
sudo dnf module reset php -y
sudo dnf module enable php:remi-8.0 -y
sudo dnf install -y php php-cli php-fpm php-mysqlnd

# Start PHP-FPM service
sudo systemctl start php-fpm

# Add any additional deployment commands as needed
