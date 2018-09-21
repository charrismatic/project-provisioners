#!/bin/bash
SITE=${1:-"default"}
PUBLIC_DIRECTORY=${2:-"public"}

MYSQL_HOST=localhost
MYSQL_DBNAME="${SITE//\./\_}"
MYSQL_DBUSER="vagrant"
MYSQL_DBPASS="SECRET"


export ACTIVE_SITE=$SITE


sudo rm /etc/apache2/sites-enabled/*.conf

# TODO: IF SITE.CONF DOES NOT EXIST

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

echo -e "\n Enabling $SITE \n"
a2ensite $SITE                                                                                                      # >> $VAGRANT_BUILD_LOG 2>&1

if ! pidof apache2 > /dev/null
then
  echo -e "\n--- Starting Apache --\n"
    service apache2 start                                                                                             # >> $VAGRANT_BUILD_LOG 2>&1
else
  echo -e "\n--- Restart Apache --\n"
    service apache2 restart                                                                                             # >> $VAGRANT_BUILD_LOG 2>&1
fi



# TODO: IF DB_NAME DOES NOT EXIST
echo -e "\n UPDATING MYSQL \n"
mysql -uroot -p$MYSQL_DBPASS -e "CREATE DATABASE $MYSQL_DBNAME"                                                     # >> $VAGRANT_BUILD_LOG 2>&1
mysql -uroot -p$MYSQL_DBPASS -e "grant all privileges on *.* to '$MYSQL_DBUSER'@'%' identified by '$MYSQL_DBPASS'"  # >> $VAGRANT_BUILD_LOG 2>&1

sudo service mysql restart                                                                                          # >> $VAGRANT_BUILD_LOG 2>&1



 CREATE DATABASE `finehat_stage`;
