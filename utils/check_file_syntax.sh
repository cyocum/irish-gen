#!/bin/sh

if [ -z "$JENA_HOME" ]
then
   echo "JENA_HOME is empty. Please set JENA_HOME\n"
   exit 1
fi

if [ -z "$IRISH_GEN_HOME" ]
then
    echo "IRISH_GEN_HOME is empty. Please set IRISH_GEN_HOME\n"
    exit 1
fi

find $IRISH_GEN_HOME  \( -name '*.trig' -o -name '*.ttl' \) -exec $JENA_HOME/bin/riot --validate --verbose 2>&1 {} + | egrep -B 1 "WARN|ERROR"

# find $IRISH_GEN_HOME  \( -name '*.trig' -o -name '*.ttl' \) -type f -print0 | xargs -0 $JENA_HOME/bin/riot --validate --verbose 2>&1 | egrep -B 1 "WARN|ERROR"

# if grep does not match something, it will set $? to 1 but
# in our case if it does not find an ERROR or WARN then that
# means success so flip the usual idea of failure in this case
if [ $? -eq 1 ]
then
    echo "SUCCESS\n"
    exit 0
else
    echo "There were errors.  See the above error messages.\n"
    exit 1
fi
