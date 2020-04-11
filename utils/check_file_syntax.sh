#!/bin/sh

if [ -z "JENA_HOME" ]
then
   echo "JENA_HOME is empty. Please set JENA_HOME\n"
   exit 1
fi

find . -name '*.trig' -print0 | xargs -0 $JENA_HOME/bin/riot --validate --verbose | egrep -B 1 "WARN|ERROR"

# if grep does not match something, it will set $? to 1 but
# in our case if it does not find an ERROR or WARN then that
# means success so flip the usual idea of failure in this case
if [ $? -eq 1 ]
then
    exit 0
else
    exit 1
fi
