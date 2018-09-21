#!/bin/bash

# NOTES:
## REQUIRES 
# PHP 7.2 or greater
# MySQL 5.6 or greater OR MariaDB 10.0 or greater
# The mod_rewrite Apache module
# HTTPS support
#  We recommend Apache or Nginx as the most robust and featureful server for running WordPress

cd ~
mkdir wp_temp && cd wp_temp
wget https://wordpress.org/latest.zip 
unzip latest.zip 
cd /var/www/
mv ~/wp_temp/wordpress/* /var/www/$ACTIVE_SITE/public
rm -rf ~/wp_temp
