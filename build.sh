#!/bin/sh
find . -name "*.trig" -print0 | xargs -0 /workspace/apache-jena-3.9.0/bin/riot --validate --verbose
echo "WTF"
