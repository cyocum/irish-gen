#!/bin/bash
find / -name '*.trig' -print0 | xargs -0 /apache-jena-3.10.0/bin/riot --validate --verbose
