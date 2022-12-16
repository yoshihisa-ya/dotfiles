#!/bin/bash

if [ $OSTYPE == 'linux-gnu' ]; then
    echo -n ' '
    cat /proc/loadavg | cut -d " " -f 1-3
fi
