# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt update && \
    apt-get install -y vim apache2 php libapache2-mod-php php-mysql mysql-server \
    phpmyadmin php-mbstring php-zip php-gd php-json php-curl sudo

# Start Apache and MySQL
RUN service apache2 start && \
    service mysql start

# Configure MySQL for phpMyAdmin
RUN service mysql start && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Modify phpMyAdmin configuration
RUN sed -i 's/\$dbserver='\''localhost'\''/\$dbserver='\''127.0.0.1'\''/' /etc/phpmyadmin/config-db.php

# Restart Apache
RUN service apache2 restart

# Expose ports for Apache and MySQL
EXPOSE 80 3306

# Start Apache and MySQL when container launches
CMD service mysql start && apache2ctl -D FOREGROUND
