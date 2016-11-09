#!/bin/bash

if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
  echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
