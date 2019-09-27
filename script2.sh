#!/bin/bash
DATE=`date '+%Y-%m-%d %H:%M:%S'`
for file in "/home/sid/ex"
do ls -l in $file;   
done
cd /home/sid
tar cvf $DATE. ex.tar.gz "/home/sid/ex"
find /home/sid/ex.tar.gz -type f -mmin +3 -exec aws s3 cp ex.tar.gz s3://sidfolders/scripts/ex.tar.gz \; 
sleep 10
echo "this is the end";

