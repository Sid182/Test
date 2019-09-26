#!/bin/bash
for file in "/home/sid/ex"
do ls -l   in $file 
done
tar  cvf ex.tar.gz "/home/sid/ex"
find -name "ex.tar.gz" -type -f -mmin +3 -exec rm ex.tar.gz\; 
echo "the end"
