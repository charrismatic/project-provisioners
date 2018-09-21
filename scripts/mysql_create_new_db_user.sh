#!/bin/bash

function create_new_db_user () {
  QUERY=""
  
  NAME="$ACTIVE_SITE"
  DB_USER="${NAME//\./\_}"
  DB_NAME="${DB_USER}_db"
  
  QUERY="create user '$DB_USER'@'10.0.2.2' identified by '$DB_USER';"
  QUERY="$QUERY grant all privileges on *.* to '$DB_USER'@'10.0.2.2' with grant option; flush privileges;"
  mysql -uroot -p "SECRET" -e \""$QUERY"\"
}

create_new_db_user 

unset create_new_db_user
