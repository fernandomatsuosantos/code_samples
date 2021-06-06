#!/bin/bash

#-e if script line fails it fails entire script
#-o will make if any command in the pipeline fails
set -eo pipefail

#Enable BASH debug mode = You will see actual commands being executed with all variables applied
[ "$DEBUG" ] && set -x