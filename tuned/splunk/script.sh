#!/bin/bash

# Control Meltdown/Spectre remediations.

. /etc/tuned/meltdown/functions

OPERATION=$1

if [[ $OPERATION == "start" ]];
  then remediate
fi

if [[ $OPERATION == "stop" ]];
  then unremediate
fi

if [[ $OPERATION == "status" ]];
  then status
fi
