#!/bin/sh

if [ -z "JENA_HOME" ]
then
   echo "JENA_HOME is empty. Please set JENA_HOME\n"
   exit 1
fi

find . -name '*.trig' -print0 | xargs -0 $JENA_HOME/bin/riot --validate --verbose | egrep -B 1 "WARN|ERROR"
