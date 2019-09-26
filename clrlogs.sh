
##############################################################################################################
#
# this script will move any log files that are older than 7 days to s3
#
##############################################################################################################

LOG_DIR=/var/log
MINS_TO_HOLD=1
NOW=`date +%Y%m%d`
FILE_MASK=$1
REM_USER=ubuntu
REM_SERVER=18.196.139.93
DEST_DIR=/tmp
echo "Starting log cleanup process ..."
for i in $(find $LOG_DIR -name $FILE_MASK.log* -type f -mmin +1)
do 
	scp $i $REM_USER@$REM_SERVER:/$DEST_DIR/
done



#tar cvf ex.tar.gz "/home/sid/ex"
#find -name "ex.tar.gz" -type -f -mmin +3 -exec rm ex.tar.gz\; 

