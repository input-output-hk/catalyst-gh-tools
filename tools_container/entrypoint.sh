#!/bin/sh -l

# We do this just to help debug when the action is invocated
pwd
ls -al
echo "$@"

"$@"
