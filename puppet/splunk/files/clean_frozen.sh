#!/bin/bash

# Frozen data includes replicated copies of the data, which is not
# needed.
#
# This script cleans all replicated buckets from the frozen directory.
# To prevent deleting files that are being written to, it only 
# looks for files older than 2 days
#
# Im my case, the frozen data is located at /splunk/frozen/<index>.
#
#    David Twersky 01/26/2016
#    jewunix@gmail.com
#

export PATH=/bin:/sbin:/usr/sbin:/usr/bin

find /splunk/frozen -type d -name "rb_*" -ctime +2 -exec rm -rf {} \; 2>/dev/null

# log to syslog that the script has run.
logger -p info -t splunk "Deleted replicated copies of frozed data on `date`"
