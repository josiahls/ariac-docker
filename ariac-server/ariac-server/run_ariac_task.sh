#!/bin/bash

# run_ariac_task.sh: A shell script to execute one ARIAC task.
# E.g.: ./run_ariac_task.sh `catkin_find --share osrf_gear`/config/qual3a.yaml
#  `catkin_find --share osrf_gear`/config/sample_user_config.yaml
#  /tmp/team_foo/finalA/1/

set -e

# Constants.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

# Define usage function.
usage()
{
  echo "Usage: $0 <task.yaml> <user.yaml> <dst_folder>"
  exit 1
}

# Call usage() function if arguments not supplied.
[[ $# -ne 3 ]] && usage

TASK_CONFIG=$1
USER_CONFIG=$2
DST_FOLDER=$3

# Create a directory for the Gazebo log and the score file.
if [ -d "$DST_FOLDER" ]; then
  echo -e "${YELLOW}Wrn: Destination folder already exists. Data might be"\
          "overwritten${NOCOLOR}"
fi
mkdir -p $DST_FOLDER

echo -n "Running ARIAC task..."

# Run the task redirecting stdout and stderr.
ARIAC_EXIT_ON_COMPLETION=1 rosrun osrf_gear gear.py -v -f $1 $2 #> $DST_FOLDER/output 2>&1 &

echo -e "${GREEN}OK${NOCOLOR}"

# Copy log files.
echo -n "Copying logs into [$DST_FOLDER]..."
cp --recursive --dereference ~/.ariac/log/* $DST_FOLDER

echo -e "${GREEN}OK${NOCOLOR}"
sleep infinity # workaround for docker run args "-it" not working

