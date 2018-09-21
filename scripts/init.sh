#!/bin/bash

## INIT 
SITE=${1:-"default"}
PUBLIC_DIRECTORY=${2:-"public"}

VAGRANT_BUILD_LOG=vm_build.log 
VAGRANT_LOG_PATH=/home/vagrant/log

PHP_VERSION="7.0"
USE_NGINX=0 

MYSQL_HOST=localhost
MYSQL_DBNAME="${SITE//\./\_}"
MYSQL_DBUSER="vagrant"
MYSQL_DBPASS="SECRET"

echo -e "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n"
echo -e "=+=+=+= INIT SYSTEM: Welcome Developer +=+=+=\n" 
echo -e "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n"


# SETUP LOGGING 
echo -e "SETTING UP LOGS \n"
mkdir $VAGRANT_LOG_PATH
touch $VAGRANT_LOG_PATH/$VAGRANT_BUILD_LOG

# ADD REPOSITORIES 
echo -e "ADDING EXTRA REPOSITORIES \n"

add-apt-repository ppa:ondrej/php -y  # >> $build_log 2>&1      ## PHP 7


# UPDATING PACKAGES 
echo -e "UPDATING PACKAGES \n"
apt-get update            # >> $VAGRANT_BUILD_LOG 2>&1


# INSTALL HELPFUL PACKAGES 
echo -e "\n INSTALLING HELPFUL PACKAGES \n"
# TOOLS
apt-get install htop nano 
# LIBS
# apt-get install python-software-properties


echo -e "\n CONFIGURING TIME \n"
apt-get install ntpdate -y                # >> $VAGRANT_BUILD_LOG 2>&1

echo -e "\n--- Syncronizing  ntp.ubuntu.com \n"
sudo /usr/sbin/ntpdate ntp.ubuntu.com    # >> $VAGRANT_BUILD_LOG 2>&1



# SETUP CRON TASKS
if sudo grep -Fxq "0 5 * * * /usr/sbin/ntpdate ntp.ubuntu.com >> /dev/null 2>&1" /var/spool/cron/crontabs/root
then
  echo -e "\n--- Skipping ntpdate cron sync, line exists ---\n"
else
  echo -e "\n--- Adding ntpdate sync line to root crontab ---\n"
  crontab -l > ohmycron   # >> $VAGRANT_BUILD_LOG 2>&1
  echo "0 5 * * * /usr/sbin/ntpdate ntp.ubuntu.com >> /dev/null 2>&1"  >> ohmycron
  crontab ohmycron
  rm ohmycron
fi


# INSTALL PHP
# TODO: ALWAYS CHECK LATEST PHP VERSION NOTES 
# http://php.net/supported-versions.php
echo -e "\n CONFIGURING PHP \n"

# IF $PHP_VERSION = "7.0"
sudo apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip
# >> $VAGRANT_BUILD_LOG 2>&1



# INSTALL APACHE
echo -e "\n ## \n CONFIGURING APACHE \n"
apt-get install apache2 -y # >> $VAGRANT_BUILD_LOG 2>&1

a2enmod php7.0         # >> $VAGRANT_BUILD_LOG 2>&1
a2enmod rewrite        # >> $VAGRANT_BUILD_LOG 2>&1
a2enmod mpm_prefork    # >> $VAGRANT_BUILD_LOG 2>&1


mkdir /var/www/default
mkdir /var/www/default/public
touch /var/www/default/public/index.html
cat <<EOF > /var/www/default/public/index.html
<h2>PROJECT FLAG MISSING</h2>
</br>
<h3>SET THE ACTIVE SITE DIRECTORY IN THE VAGRANTFILE HEADER</h3>
EOF

rm -rf /var/www/html

service apache2 restart

# IF USE_NGINX=1 
# INSTALL NGINX 
#sudo apt-get install -y nginx
#sudo apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip


## CREATE NEW VHOST.CONF FILE
echo -e "\n--- Creating Virualhost.conf for $SITE ---\n"
touch /etc/apache2/sites-available/$SITE.conf
cat <<EOF > /etc/apache2/sites-available/${SITE}.conf
<VirtualHost *:80>
    ServerAdmin web@dev.site
    DocumentRoot /var/www/${SITE}/${PUBLIC_DIRECTORY}
    ServerName ${SITE}
    <Directory /var/www/${SITE}/${PUBLIC_DIRECTORY}/>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog /var/log/apache2/error_log
    ErrorLogFormat "[%t][%l] %F: %E: [%a] %M" 
    #OR  %h %l %u %{%Y-%m-%d %H:%M:%S}t \"%r\ 
    CustomLog /var/log/apache2/access_log common
</VirtualHost>
EOF


echo -e "\n ServerName: ${SITE} \n Directory: /var/www/${SITE} \n DocumentRoot: /var/www/${SITE}/${PUBLIC_DIRECTORY}"


echo -e "\n DISABLING PREVIOUSLY ENABLED SITES \n"
a2dissite 000-default.conf                            # >> $VAGRANT_BUILD_LOG 2>&1

# TODO CREATE FUNCTION TO CLEAR ALL ENABLED SITES 
# A2DISSITE REMOVES SYMBOLIC LINK TO SITES-AVAIALABLE.
# find /etc/apache2/sites-enabled/ -type l -exec rm -i "{}" \;
# rm /etc/apache2/sites-enabled/*
# a2dissite *


echo -e "\n Enabling $SITE \n"
a2ensite $SITE                                                                                                      # >> $VAGRANT_BUILD_LOG 2>&1



## Remove default web server directory tags from apache2.conf for security
sed -i '/^<Directory[ ]\/var\/www\/>/,/<\/Directory>/d' /etc/apache2/apache2.conf                                   # >> $VAGRANT_BUILD_LOG 2>&1
# Removing /usr/share web server directory from apache2.conf 
sed -i '/^<Directory[ ]\/usr\/share\/>/,/<\/Directory>/d' /etc/apache2/apache2.conf                                 # >> $VAGRANT_BUILD_LOG 2>&1


if ! pidof apache2 > /dev/null
then
  echo -e "\n--- Starting Apache --\n"
    service apache2 start                                                                                             # >> $VAGRANT_BUILD_LOG 2>&1
else
  echo -e "\n--- Restart Apache --\n"
    service apache2 restart                                                                                             # >> $VAGRANT_BUILD_LOG 2>&1
fi


# FIX ANY BROKEN PACKAGES BEFORE COTINUE
apt install -f 


# CONFIGURE MYSQL
echo -e "\n CONFIGURING MYSQL \n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_DBUSER"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_DBPASS"

apt-get -y install mysql-server mysql-server-5.5      # >> $VAGRANT_BUILD_LOG 2>&1


echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -p$MYSQL_DBPASS -e "CREATE DATABASE $MYSQL_DBNAME"                                                     # >> $VAGRANT_BUILD_LOG 2>&1
mysql -uroot -p$MYSQL_DBPASS -e "grant all privileges on *.* to '$MYSQL_DBUSER'@'%' identified by '$MYSQL_DBPASS'"  # >> $VAGRANT_BUILD_LOG 2>&1

sed -i '/skip-external-locking/s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i '/bind-address/s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf

echo -e "\n--- MySQL User: [${MYSQL_DBNAME}] Password: [${MYSQL_DBPASS}] on Database: [${MYSQL_DBNAME}] ---\n"


service mysql restart                                                                                          # >> $VAGRANT_BUILD_LOG 2>&1


# CLEAN UP
echo -e "\n CLEANING UP \n"
apt-get autoremove -y


# FINISH 
echo -e "\n FINISHED"
