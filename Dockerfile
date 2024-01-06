# Use the official Red Hat Universal Base Image (UBI) 8 as a base image
#FROM registry.access.redhat.com/ubi8/ubi

# Install the httpd package
#RUN yum install -y httpd && \
    #yum clean all

# Copy the local configuration file to the container
#COPY httpd.conf /etc/httpd/conf/httpd.conf

# Expose port 80 for the web server
#EXPOSE 8080

# Start the httpd service when the container starts
#CMD ["httpd", "-D", "FOREGROUND"]

# Use the official Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Define an argument for the port with a default value of 8080
ARG PORT=8080

# Install necessary packages (replace with your specific requirements)
RUN yum -y install httpd

# Update the Apache configuration to use the specified port
RUN sed -i "s/Listen 80/Listen $PORT/" /etc/httpd/conf/httpd.conf

# Optionally, copy your custom configuration files or website content
# COPY ./custom-config.conf /etc/httpd/conf.d/custom-config.conf
# COPY ./html /var/www/html

# Expose the port defined during build time
EXPOSE $PORT

# The main command to start Apache when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
