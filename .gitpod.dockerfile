# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y vim apache2 php libapache2-mod-php php-mysql mysql-server phpmyadmin php-mbstring php-zip php-gd php-json php-curl

# Start Apache and MySQL services
RUN service apache2 start && \
    service mysql start

# Configure MySQL root user and phpMyAdmin
RUN mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;" && \
    sed -i "s/\$dbserver='localhost';/\$dbserver='127.0.0.1';/" /etc/phpmyadmin/config-db.php

# Expose the default Apache port
EXPOSE 80

# Set the command to run Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
