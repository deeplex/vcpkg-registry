#!/usr/bin/env bash

script_dir="$(dirname -- "$( readlink -f -- "$0"; )" )"

vcpkg --x-builtin-ports-root=./ports format-manifest $@
