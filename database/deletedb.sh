#!/bin/bash
MYSQL_HOST=$1
MYSQL_PORT=$2
MYSQL_USER=$3
MYSQL_PASSWORD=$4
MYSQL_DB=$5
echo " =================================Deleting Database================"
if ! mysql -h $MYSQL_HOST  -u $MYSQL_USER -p$MYSQL_PASSWORD -P $MYSQL_PORT -e "use $MYSQL_DB"; then
echo "db doesn't exist"
else
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -P $MYSQL_PORT -e "DROP DATABASE $MYSQL_DB"
fi

