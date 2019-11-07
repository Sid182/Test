#!/bin/bash

#function usage() {
#  echo "$0 (start|stop|status)"
#}

#if [ $# -ne 1 ]; then
#  usage
#  exit 2
#fi
ACTION=$1
EC2_LIST_ID=$2
DEBUG="echo "
DEBUG=""
REGION=eu-central-1

INSTANCE_STS=`aws ec2 describe-instance-status --region $REGION --instance-ids ${EC2_LIST_ID[@]} --include-all-instances | jq -r '.InstanceStatuses[].InstanceState.Name'`

echo "InstanceStatus : $INSTANCE_STS"

EXIT=0
for i in  $INSTANCE_STS
do
if [ "$1" = "start" ]; then
  if [ "$INSTANCE_STS" = "running" ]; then
    echo "instance is already running."
  else
    echo "start instance..."
    $DEBUG aws ec2 start-instances --instance-ids ${EC2_LIST_ID[@]} --region $REGION
    EXIT=$?
  fi
elif [ "$1" = "stop" ]; then
  if [ "$i" = "running" ]; then
    echo "stop instance..."
    $DEBUG aws ec2 stop-instances --instance-ids ${EC2_LIST_ID[@]} --region $REGION
    EXIT=$?
  else
    echo "instance is already stopped."
  fi
elif [ "$1" = "status" ]; then
  echo "Status Check only."
#else
#  usage
#  EXIT=2
fi

exit $EXIT
done
