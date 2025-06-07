#!/usr/bin/env bash

script_dir="$(dirname -- "$( readlink -f -- "$0"; )" )"

vcpkg --x-builtin-ports-root="$script_dir/../ports" --x-builtin-registry-versions-dir="$script_dir/../versions" x-add-version $@
