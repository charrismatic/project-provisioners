#!bin/bash

mysql -uroot -p "" -e "create user 'development'@'10.0.2.2' identified by 'development'; grant all privileges on *.* to 'development'@'10.0.2.2' with grant option; flush privileges;"
