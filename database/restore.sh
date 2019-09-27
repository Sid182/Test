#!/bin/bash
BACKUP_DIR=$1
MYSQL_HOST=$2
MYSQL_PORT=$3
MYSQL_USER=$4
MYSQL_PASSWORD=$5
DATABASE_NAME=$6
AMAZON_S3_BUCKET=$7
LATEST=$8
echo "=================================Starting restore=============================="
KEY=`aws s3 ls ${AMAZON_S3_BUCKET} --recursive | sort | tail -n 1 | awk '{print $4}'`
sudo mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -P $MYSQL_PORT -e "CREATE DATABASE $DATABASE_NAME"
aws s3 cp $AMAZON_S3_BUCKET/$KEY $LATEST
restore_mysql(){
         mysqldump -h $MYSQL_HOST \
           -P $MYSQL_PORT \
           -u $MYSQL_USER \
           -p$MYSQL_PASSWORD $DATABASE_NAME < $LATEST
           
}
restore_mysql
 
 
