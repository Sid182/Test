#!/bin/bash
BACKUP_DIR=$1
MYSQL_HOST=$2
MYSQL_PORT=$3
MYSQL_USER=$4
MYSQL_PASSWORD=$5
DATABASE_NAME=$6
AMAZON_S3_BUCKET=$7
DATE=$(date +"%Y-%m-%d-%H-%M")
mkdir -p $BACKUP_DIR
echo " =================================Starting backup=============================="
if ! mysql -h $MYSQL_HOST  -u $MYSQL_USER -p$MYSQL_PASSWORD -P $MYSQL_PORT -e "use $DATABASE_NAME"; then
echo "db doesn't exist"
else
         mysqldump -h$MYSQL_HOST \
           -P$MYSQL_PORT \
           -u$MYSQL_USER \
           -p$MYSQL_PASSWORD $DATABASE_NAME | gzip > $BACKUP_DIR/$DATABASE_NAME-$DATE.sql.gz
echo " ================================Uploading to s3 bucket========================"
upload_s3(){
     aws s3 cp $BACKUP_DIR/$DATABASE_NAME-$DATE.sql.gz $AMAZON_S3_BUCKET
}
upload_s3
fi
