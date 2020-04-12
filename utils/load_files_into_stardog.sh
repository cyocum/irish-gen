#!/bin/sh

if [ -z "$STARDOG_HOME" ]
then
    echo "STARDOG_HOME is not set.  Please set STARDOG_HOME\n"
    exit 1
fi

if [ -z "$IRISH_GEN_HOME" ]
then
    echo "IRISH_GEN_HOME is not set. Please set IRISH_GEN_HOME\n"
    exit 1
fi

IRISH_GEN_DB_NAME=$1

find $IRISH_GEN_HOME -name '*.trig' -print0 | xargs -0 $STARDOG_HOME/bin/stardog data add $IRISH_GEN_DB_NAME $IRISH_GEN_HOME/earlyIrishRelationship.ttl $IRISH_GEN_HOME/earlyIrishTitles.ttl $IRISH_GEN_HOME/oldIrishOntology.ttl 

