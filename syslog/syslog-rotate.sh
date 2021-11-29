#!/bin/sh

# Compress files older than 2 hours
find /var/log/splunk -type f -mmin +300 -exec gzip {} \;

# Delete compressed files older than 3 days
find  /var/log/splunk -type f -mtime +3 -name "*gz" -exec /bin/rm {} \;
