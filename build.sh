#!/bin/sh
find . -name "*.trig" -print0 | xargs -0 ${JENA_HOME}/bin/riot --validate --verbose
find . -name "*apache*" -print
echo "WTF"
