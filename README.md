# Splunk Configuration and Apps

##Directory structure:
- etc
- config

## Splunk Installation:
These configurations are intended for CentOS/RedHat 7 Linux.

### System Configuration:
Splunk reccomends to disable Transparent Huge Pages performance reasons.
There are several ways to disable THP, either by appending "**transparent_hugepage=never**" in to **/etc/sysconfig/grub.conf**, and rebuild the grub. However, that will only apply never to **/sys/kernel/mm/transparent_hugepage/never** and not to **/sys/kernel/mm/transparent_hugepage/defrag**.
To have it completely disabled, a startup script needs to be run. So I combined both of them in a single script, for simplicity.

#### Disabling THP
Copy the **configs/disable_defrag.sh** to **/usr/local/bin**, and make it executable.

Copy **configs/thp-defrag.service** to **/etc/systemd/system/thp-defrag.service**.
I set up Splunk to start on boot with systemd, by creating a splunk.system file in **/etc/systemd/system/splunk.service**. That file includes the ulimit settings for splunk, and the THP settings.

To disable THP live, you can run:
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
 
> echo never > /sys/kernel/mm/transparent_hugepage/defrag

To if THP is disabled. see if the output of the following command produces zero values, or if you configured it live, those numbers do not increase.

> egrep 'trans|thp' /proc/vmstat

