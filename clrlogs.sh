echo "
##############################################################################################################
#
# this script will move any log files that are older than x days to remote server
#
##############################################################################################################
"
LOG_DIR=/var/log
DAYS_TO_HOLD=+15
FILE_MASK=$1
REM_USER=ubuntu
REM_SERVER=18.196.139.93
DEST_DIR=/tmp/backup_logs
echo "Copying logs from $LOG_DIR to $REM_SERVER:$DEST_DIR"
for i in $(find $LOG_DIR -name $FILE_MASK.log* -type f -mtime $DAYS_TO_HOLD)
do 
if ssh $REM_USER@$REM_SERVER "[ ! -d $DEST_DIR ]"; then
echo "Creating Destination directory"
ssh $REM_USER@$REM_SERVER "mkdir $DEST_DIR"
scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/ 
else 
scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/ 
fi
done
echo "Logs is successfully copied to destination folder"
sleep 2
echo "List of copied logs"
ssh $REM_USER@$REM_SERVER  "cd $DEST_DIR && ls -l"
echo "
##############################################################################################################
#
#                                 Done
#
##############################################################################################################
"



