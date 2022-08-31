#/bin/bash
ps -ef | grep "rclone" | grep -v 'grep' | awk '{ print $2 }' | xargs kill
