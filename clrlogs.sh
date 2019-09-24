
##############################################################################################################
#
# this script will move any log files that are older than 7 days to s3
#
##############################################################################################################

LOG_DIR=/some/log/dir
DAYS_TO_HOLD=7
NOW=`date +%Y%m%d`

echo "Starting log cleanup process ..."

find ${LOG_DIR} -name "*your_file_pattern_match_here*" -mtime +${DAYS_TO_HOLD} -exec aws s3 mv {} s3://somebucket-that-holds-logs \; >/dev/null 2>&1

echo "Log clean up completed"
