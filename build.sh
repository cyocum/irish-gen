#!/bin/sh
apt update
apt install -y wget openjdk-11-jdk-headless
wget https://www-eu.apache.org/dist/jena/binaries/apache-jena-3.9.0.tar.gz
tar xfvz apache-jena-3.9.0.tar.gz
sed -i 's/WARN/INFO/g' ./apache-jena-3.9.0/jena-log4j.properties
find . -name "*.trig" -print0 | xargs -0 ./apache-jena-3.9.0/bin/riot --validate --verbose

