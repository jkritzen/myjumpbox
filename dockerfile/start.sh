#!/bin/bash

# generate host keys if not present
ssh-keygen -A

# # ensure the following environment variables are set. exit script and container if not set.
test $ssh

/usr/local/bin/confd -onetime -backend env

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
