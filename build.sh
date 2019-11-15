#!/bin/bash
find / -name '*.trig' -print0 | xargs -0 /apache-jena-3.13.1/bin/riot --validate --verbose
