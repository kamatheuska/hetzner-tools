#!/bin/bash

function get_absolute_path () {
    echo $(dirname "$(readlink -f "${BASH_SOURCE[1]}")")
}

