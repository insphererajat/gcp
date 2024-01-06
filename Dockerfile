# Use the official Red Hat Universal Base Image (UBI) 8 as a base image
FROM registry.access.redhat.com/ubi8/ubi

# Install the httpd package
RUN yum install -y httpd && \
    yum clean all

# Copy the local configuration file to the container
#COPY httpd.conf /etc/httpd/conf/httpd.conf

# Expose port 80 for the web server
EXPOSE 8080

# Start the httpd service when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
