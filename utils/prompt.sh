#!/bin/bash

function confirm() {
    read -p "Are you sure? (y/n): " -n 1 -r
    echo    # move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}

