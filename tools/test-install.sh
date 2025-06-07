#!/usr/bin/env bash

script_dir="$(dirname -- "$( readlink -f -- "$0"; )" )"

vcpkg install --overlay-ports="$script_dir/../ports" $@
