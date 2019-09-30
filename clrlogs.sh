\echo "
##############################################################################################################
#
# this script will move any log files that are older than x days to remote server
#
##############################################################################################################
"

FILE_MASK=$1
FILE_TYPE=$2
LOG_DIR=$3
MINS_TO_HOLD=$4
REM_USER=$5
REM_SERVER=$6
DEST_DIR=$7

if ssh $REM_USER@$REM_SERVER "[ ! -d $DEST_DIR ]"; then
echo "Creating Destination directory"
ssh $REM_USER@$REM_SERVER "mkdir $DEST_DIR"
fi

echo "======================Moving logs======================"
for i in $(find $LOG_DIR -name "$FILE_MASK.$FILE_TYPE" -type f -mmin +$MINS_TO_HOLD)
do
echo "Copy $i from $LOG_DIR to $REM_SERVER:$DEST_DIR"
rsync -az --remove-source-files -e ssh $i $REM_USER@$REM_SERVER:/$DEST_DIR/
done

echo "List of moving files"
ssh $REM_USER@$REM_SERVER  "cd $DEST_DIR && ls -l"
echo "
##############################################################################################################
#
#                                 Done
#
##############################################################################################################
"

