
MYSQL_DBPASS='SECRET'
MYSQL_DBNAME='development'
MYSQL_DBUSER=$MYSQL_DBNAME

# TODO: IF DB_NAME DOES NOT EXIST
echo -e "\n UPDATING MYSQL \n"
mysql -uroot -p$MYSQL_DBPASS -e "CREATE DATABASE $MYSQL_DBNAME"                                                    
mysql -uroot -p$MYSQL_DBPASS -e "grant all privileges on *.* to '$MYSQL_DBUSER'@'%' identified by '$MYSQL_DBPASS'" 

sudo service mysql restart                                                                                         
