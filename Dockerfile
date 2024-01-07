# Use the official Red Hat Universal Base Image (UBI) as the base image
#FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
#ARG PORT=8080

# Install necessary packages (replace with your specific requirements)
#RUN yum -y install httpd

# Update the Apache configuration to use the specified port
#RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Optionally, copy your custom configuration files or website content
# COPY ./custom-config.conf /etc/httpd/conf.d/custom-config.conf
# COPY ./html /var/www/html

# Copy your index.html file into the Apache document root
#COPY ./index.html /var/www/html/index.html

# Expose the port defined during build time
#EXPOSE $PORT

# The main command to start Apache when the container starts
#CMD ["httpd", "-D", "FOREGROUND"]

# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
ARG PORT=8080

# Install necessary packages (including PHP 8.0)
RUN yum -y install httpd php php-cli php-json

# Update the Apache configuration to use the specified port
RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Optionally, copy your custom configuration files or website content
#COPY ./vhosts.conf /etc/httpd/conf.d/vhosts.conf

# Create a directory for your PHP project
#RUN mkdir -p /var/www/text

# Copy your index.php file into the project directory
COPY ./index.php /var/www/html/index.php

# Set index.php as the default document
#RUN echo "DirectoryIndex index.php" >> /etc/httpd/conf/httpd.conf

# Expose the port defined during build time
EXPOSE $PORT

# The main command to start Apache when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
