echo "
##############################################################################################################
#
# this script will move any log files that are older than x days to remote server
#
##############################################################################################################
"

FILE_MASK=$1
FILE_TYPE=$2
LOG_DIR=/var/log
DAYS_TO_HOLD=+1
REM_USER=ubuntu
REM_SERVER=18.196.139.93
DEST_DIR=/tmp/backup_logs


if ssh $REM_USER@$REM_SERVER "[ ! -d $DEST_DIR ]"; then
echo "Creating Destination directory"
ssh $REM_USER@$REM_SERVER "mkdir $DEST_DIR"
fi

echo "Copying logs from $LOG_DIR to $REM_SERVER:$DEST_DIR"
for i in $(find $LOG_DIR -name $FILE_MASK.$FILE_TYPE -type f -mmin $DAYS_TO_HOLD)
do 
echo "Copy $i from $LOG_DIR to $REM_SERVER:$DEST_DIR"
rsync -havz --remove-source-files -e ssh $i $REM_USER@$REM_SERVER:/$DEST_DIR/
#scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/ 

done

echo "List of copied logs"
ssh $REM_USER@$REM_SERVER  "cd $DEST_DIR && ls -l"
echo "
##############################################################################################################
#
#                                 Done
#
##############################################################################################################
"
