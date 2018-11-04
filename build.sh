#!/bin/sh
apt update
apt install -y wget
wget https://www-eu.apache.org/dist/jena/binaries/apache-jena-3.9.0.tar.gz
tar xfvz apache-jena-3.9.0.tar.gz
find . -name "*.trig" -print0 | xargs -0 ./apache-jena-3.9.0/bin/riot --validate --verbose

