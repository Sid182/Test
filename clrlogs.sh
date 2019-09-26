LOG_DIR=/var/log
MINS_TO_HOLD=1
NOW=`date +%Y%m%d`
FILE_MASK=$1
REM_USER=ubuntu
REM_SERVER=18.196.139.93
DEST_DIR=/tmp/backup
echo "
##############################################################################################################
#
# this script will move any log files that are older than x days to remote server
#
##############################################################################################################
"
for i in $(find $LOG_DIR -name $FILE_MASK.log* -type f -mtime +15)
do 
if ssh $REM_USER@$REM_SERVER "[ ! -d $DEST_DIR ]"; then
echo "Creating Destination directory"
ssh $REM_USER@$REM_SERVER "mkdir $DEST_DIR"
echo "copying logs" 
scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/
else
scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/
fi
done





