#!/bin/bash

if type sensors >/dev/null; then
    echo -n ' '
    sensors | grep "Package id 0:" | cut -c 16-23
fi
