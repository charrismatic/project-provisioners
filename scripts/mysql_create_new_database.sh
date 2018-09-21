#!/bin/bash

MYSQL_RESET="FALSE"

function create_new_database () {
  QUERY=""
  
  NAME="$ACTIVE_SITE"
  DB_USER="${NAME//\./\_}"
  DB_NAME="${DB_USER}_db"
  
  if [ $MYSQL_RESET = "TRUE" ]  
  then 
    QUERY="DROP DATABASE IF EXISTS $DB_NAME;"
  fi

  QUERY="${QUERY}CREATE DATABASE IF NOT EXISTS $DB_NAME;" 
  QUERY="$QUERY GRANT ALL ON $DB_NAME.* to $DB_USER@localhost IDENTIFIED BY '$DB_USER';"
  
  mysql -uroot -pSECRET -e \"$QUERY\"  
}

create_new_database

unset create_new_database
